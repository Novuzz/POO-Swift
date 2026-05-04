import Foundation

enum Experiencia: String {
    case iniciante = "Iniciante", intermediario = "Intermediário", avancado = "Avançado"
}

enum Categoria: String {
    case musculacao = "Musculação", spinning = "Spinning", yoga = "Yoga", funcional = "Funcional", luta = "Luta"
}

enum TipoPlano: String {
    case mensal = "Mensal", trimestral = "Trimestral", anual = "Anual"
}

enum StatusMaquina: String {
    case funcionando = "Funcionando", emManutencao = "Em Manutenção", quebrada = "Quebrada"
}


protocol Manutencao {
    var id: String { get set }
    var nome: String { get set }
    var historico: [String] { get set }
    var status: StatusMaquina { get set }
    func reparar()
    func emManutencao()
    func quebrada()
}

protocol Aula {
    var nome: String { get set }
    var categoria: Categoria { get set }
    var descricao: String { get set }
}


class Plano {
    private(set) var nome: String
    private(set) var valor: Double
    private(set) var tipo: TipoPlano
    private(set) var personal: Bool

    init(nome: String, tipo: TipoPlano, personal: Bool, valor: Double) {
        self.nome = nome
        self.tipo = tipo
        self.valor = valor
        self.personal = personal
    }
}

class Pessoa {
    var id: String
    var nome: String
    var email: String
    
    init(nome: String, email: String) {
        self.id = String(Int.random(in: 1000...19999))
        self.nome = nome
        self.email = email
    }
}


class Instrutor: Pessoa {
    var horarios: Set<String>
    init(nome: String, email: String, horarios: Set<String>) {
        self.horarios = horarios
        super.init(nome: nome, email: email)
    }
}

class TreinoPersonal: Aula {
    var nome: String
    var categoria: Categoria
    var descricao: String
    
    init(nome: String, categoria: Categoria, descricao: String = "") {
        self.nome = nome
        self.categoria = categoria
        self.descricao = descricao
    }
}

class TreinoColetivo: Aula {
    var nome: String
    var categoria: Categoria
    var descricao: String
    
    init(nome: String, categoria: Categoria, descricao: String = "") {
        self.nome = nome
        self.categoria = categoria
        self.descricao = descricao
    }
}

class Aluno: Pessoa {
    var experiencia: Experiencia = .iniciante
    var inscricoes: Set<String> = []
    var instrutor: Instrutor?
    var horario: String?
    var plano: Plano 
    var aula: Aula
    
    init(nome: String, email: String, plano: Plano, aula: Aula, instrutor: Instrutor? = nil, horario: String? = nil) {
        self.plano = plano
        self.aula = aula
        self.instrutor = instrutor
        self.horario = horario
        super.init(nome: nome, email: email)
    }
}

class Maquina: Manutencao {
    var id: String
    var nome: String
    var historico: [String] = []
    var status: StatusMaquina

    init(nome: String, status: StatusMaquina = .funcionando) {
        self.id = String(Int.random(in: 1000...19999))
        self.nome = nome
        self.status = status
    }

    func registrarEvento(_ mensagem: String) {
        let df = DateFormatter()
        df.dateFormat = "dd/MM HH:mm"
        let msg = "\(mensagem) em \(df.string(from: Date()))"
        historico.append(msg)
        print(msg)
    }

    func reparar() {
        if status == .funcionando { print("A Máquina já está em ordem") }
        else { status = .funcionando; registrarEvento("A Máquina foi reparada") }
    }

    func emManutencao() {
        if status == .emManutencao { print("A Máquina já está em manutenção") }
        else { status = .emManutencao; registrarEvento("A Máquina entrou em manutenção") }
    }

    func quebrada() {
        if status == .quebrada { print("A Máquina já está quebrada") }
        else { status = .quebrada; registrarEvento("A Máquina foi marcada como quebrada") }
    }
}

class DB {
    var instrutores: [String: Instrutor] = [:]
    var planos: [String: Plano] = [:]
    var alunos: [String: Aluno] = [:]
    var maquinas: [String: Maquina] = [:]
    var aulas: [String: Aula] = [:]

    init() {
        for i in 1...3 {
            let ins = Instrutor(nome: "Professor \(i)", email: "p\(i)@gym.com", horarios: ["08:00", "14:00", "19:00"])
            instrutores[ins.id] = ins
        }
        
        planos["Basic"] = Plano(nome: "Basic", tipo: .mensal, personal: false, valor: 100.0)
        planos["Premium"] = Plano(nome: "Premium", tipo: .anual, personal: true, valor: 250.0)
        
        // Mock Máquinas
        for i in 1...3 {
            let maq = Maquina(nome: "Esteira \(i)")
            maquinas[maq.id] = maq
        }
        self.aulas["Spinning"] =  TreinoColetivo(nome: "Spinning", categoria: .spinning, descricao: "Aula de alta intensidade em grupo.")
        self.aulas["Musculação"] =  TreinoColetivo(nome: "Musculação", categoria: .musculacao, descricao: "Circuito coletivo.")
        self.aulas["Yoga"] =  TreinoPersonal(nome: "Yoga", categoria: .yoga, descricao: "Foco em respiração e flexibilidade.")
        self.aulas["Luta"] =  TreinoPersonal(nome: "Luta", categoria: .luta, descricao: "Treino de Boxe/Muay Thai.")
    }
}

class Main {
    func main() {
        let db = DB()
        var rodando = true

        while rodando {
            print("Bem-vindo")
            print("1. Criar Conta Aluno | 2. Mostrar Planos | 3. Mostrar Instrutores")
            print("4. Mostrar Alunos    | 5. Mostrar Máquinas | 6. Status: Funcionando")
            print("7. Status: Manutenção| 8. Status: Quebrada  | 0. Sair")
            
            if let option = readLine() {
                switch option {
                case "1": criarAluno(db: db)
                case "2": mostrarPlanos(db: db)
                case "3": mostrarInstrutores(db: db)
                case "4": mostrarAlunos(db: db)
                case "5": mostrarMaquinas(db: db)
                case "6": mudarStatusMaquina(db: db, novoStatus: .funcionando)
                case "7": mudarStatusMaquina(db: db, novoStatus: .emManutencao)
                case "8": mudarStatusMaquina(db: db, novoStatus: .quebrada)
                case "0": rodando = false
                default: print("Opção inválida")
                }
            }
            let _ = readLine()
        }
    }

    func criarAluno(db: DB) {

        var personal: Instrutor? = nil

        print("Nome:")
        guard let nome = readLine() else { return }
        
        print("Email:")
        let emailStr = email(pessoa: db.alunos)

        mostrarPlanos(db: db)
        print("Digite o nome do plano:")
        guard let planoNome = readLine(), let plano = db.planos[planoNome] else {
            print("Plano inválido!"); return
        }

        guard let aula = escolherAula(db: db, plano: plano) else {
        print("Não é possível prosseguir sem selecionar uma aula.")
        return
    }
        if aula is TreinoColetivo && plano.personal
        {
            print("Deseja ter um personal? (s/n)")
            
            if let opcao = readLine(), opcao == "s"
            {
                personal = escolherInstrutor(db: db)
            }
        }
        else if aula is TreinoPersonal
        {
            personal = escolherInstrutor(db: db)
        }
        
        let novoAluno = Aluno(nome: nome, email: emailStr, plano: plano, aula: aula, instrutor: personal)
        db.alunos[novoAluno.id] = novoAluno
        print("Aluno cadastrado com ID: \(novoAluno.id)")
    }

    func escolherInstrutor(db: DB) -> Instrutor?
    {
        mostrarInstrutores(db: db)
                if let instrutorId = readLine(), let instrutor = db.instrutores[instrutorId] 
                {
                    print("Digite o horário desejado:")

                        var horario: String = ""

                        var horarioValido = false

                        repeat
                        {
                            if let input = readLine() {
                                horario = input
                            } else {
                                print("Entrada inválida. Tente novamente.")
                            }
                            horarioValido = instrutor.horarios.contains(horario)
                            if horarioValido {
                                instrutor.horarios.remove(horario)
                            }else {
                                print("Horário indisponível. Tente novamente.")
                            }
                        } while !horarioValido 
                        instrutor.horarios.remove(horario)
                        return instrutor
                }
                return nil
    }

    func mudarStatusMaquina(db: DB, novoStatus: StatusMaquina) {
        mostrarMaquinas(db: db)
        print("Digite o ID da máquina:")
        if let id = readLine(), let maq = db.maquinas[id] {
            switch novoStatus {
            case .funcionando: maq.reparar()
            case .emManutencao: maq.emManutencao()
            case .quebrada: maq.quebrada()
            }
        } else {
            print("Máquina não encontrada.")
        }
    }


    func escolherAula(db: DB, plano: Plano) -> Aula? {
    print("\n--- Seleção de Aulas (\(plano.personal ? "Individuais" : "Coletivas")) ---")
    
    let aulasFiltradas = db.aulas.values.filter { aula in
        if plano.personal {
            return aula is TreinoPersonal || aula is TreinoColetivo
        } else {
            return aula is TreinoColetivo
        }
    }

    if aulasFiltradas.isEmpty {
        print("Nenhuma aula disponível para este tipo de plano.")
        return nil
    }

    for (index, aula) in aulasFiltradas.enumerated() {
        print("\(index + 1). \(aula.nome) - Categoria: \(aula.categoria.rawValue)")
    }

    print("Escolha o número da aula desejada:")
    if let input = readLine(), let escolha = Int(input), escolha > 0 && escolha <= aulasFiltradas.count {
        let aulaSelecionada = Array(aulasFiltradas)[escolha - 1]
        print("Aula '\(aulaSelecionada.nome)' selecionada com sucesso!")
        return aulaSelecionada
    }

    print("Seleção inválida.")
    return nil
}
     func email(pessoa: Dictionary<String, Pessoa>) -> String

    {
        var email: String = ""
        var emailValido = false
        repeat
        {
             print("Digite seu email:")
            if let input = readLine() {
                email = input
            } else {
                 print("Entrada inválida. Tente novamente.")
            }
            emailValido = pessoa.values.contains(where: { $0.email == email })
                if emailValido {
                    print("Email já cadastrado. Tente novamente.")
                }
        }
        while emailValido
        return email
    } 
    func mostrarPlanos(db: DB) {
        db.planos.values.forEach { print("- \($0.nome): R$\($0.valor) (Personal: \($0.personal))") }
    }

    func mostrarInstrutores(db: DB) {
        db.instrutores.forEach { print("ID: \($0.key) | Nome: \($0.value.nome) | \($0.value.horarios)") }
    }

    func mostrarAlunos(db: DB) {
        db.alunos.values.forEach { print("- \($0.nome) | Plano: \($0.plano.nome)") }
    }

    func mostrarMaquinas(db: DB) {
        db.maquinas.values.forEach { print("ID: \($0.id) | \($0.nome) | Status: \($0.status)") }
    }
}

let programa = Main()
programa.main()