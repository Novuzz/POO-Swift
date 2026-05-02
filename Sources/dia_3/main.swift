import Foundation

enum Experiencia: String {
    case iniciante = "Iniciante"
    case intermediario = "Intermediário"
    case avancado = "Avançado"
}

enum Categoria: String {
    case musculacao = "Musculação"
    case spinning  = "Spinning"
    case yoga = "Yoga"
    case funcional = "Funcional"
    case luta = "Luta"
}

enum TipoPlano: String {
    case mensal = "Mensal"
    case trimestral = "Trimestral"
    case anual = "Anual"
}

class Plano {
    private(set) var nome: String
    private(set) var valor: Double
    private(set) var tipo: TipoPlano
    private(set) var personal: Instrutor?
    private(set) var horario: String?

    init(nome: String, tipo: TipoPlano) {
        self.nome = nome
        self.tipo = tipo
        self.valor = 120.0
    }

    init(nome: String, tipo: TipoPlano, instrutor: Bool, horario: String) {
        self.nome = nome
        self.tipo = tipo
        self.valor = 120.0
        if instrutor {
            self.personal = Instrutor(nome: "Aleatório", email: "aleatorio@gmail.com", horarios: [horario])
            self.horario = horario
        }
    }
}

class Pessoa {
    var nome: String
    var email: String
    
    init(nome: String, email: String) {
        self.nome = nome
        self.email = email
    }
}

class Aluno: Pessoa {
    var experiencia: Experiencia 
    var inscricoes: Set<String> = []
    var plano: Plano 
    
    init(nome: String, email: String, plano: Plano) {
        self.plano = plano
        self.experiencia = .iniciante
        super.init(nome: nome, email: email)
    }
}

class Instrutor: Pessoa {
    var horarios: Set<String>
    
    init(nome: String, email: String, horarios: Set<String>) {
        self.horarios = horarios
        super.init(nome: nome, email: email)
    }
}

protocol Manutencao {
    var id: String { get set }
    var nome: String { get set }
    var historico: [String] { get set }

    func reparar()
    func quebrada()
}

protocol Aula {
    var nome: String { get set }
    var categoria: Categoria { get set }
    var instrutor: Instrutor { get set }
    var descricao: String { get set }
}

class TreinoPersonal: Aula {
    var nome: String
    var categoria: Categoria
    var instrutor: Instrutor
    var descricao: String
    
    init(nome: String, categoria: Categoria, instrutor: Instrutor, descricao: String) {
        self.nome = nome
        self.categoria = categoria
        self.instrutor = instrutor
        self.descricao = descricao
    }
}

class TreinoColetivo: Aula {
    var nome: String
    var categoria: Categoria
    var instrutor: Instrutor
    var descricao: String
    
    init(nome: String, categoria: Categoria, instrutor: Instrutor, descricao: String) {
        self.nome = nome
        self.categoria = categoria
        self.instrutor = instrutor
        self.descricao = descricao
    }
}

class Maquina: Manutencao {
    var id: String
    var nome: String
    var historico: [String] = []
    var estaFuncionando: Bool = true

    init(nome: String) {
        self.id = String(Int.random(in: 1000...19999))
        self.nome = nome
    }
func reparar() {

        if estaFuncionando

        {

            print("A Máquina Está em ordem")

        } else

        {

            let date = Date()

            let hour = Calendar.current.component( .hour, from: date)

            let minute = Calendar.current.component(.minute, from: date)

            let day = Calendar.current.component(.day, from: date)

            let month = Calendar.current.component(.month, from: date)

            let message = "A Máquina foi reparada em \(day) de \(month) as \(hour):\(minute)"

            print(message)

            historico.append(message)

            estaFuncionando = true

        }

    }

    func quebrada() {

        if estaFuncionando

        {

            let date = Date()

            let hour = Calendar.current.component(.hour, from: date)

            let minute = Calendar.current.component(.minute, from: date)

            let day = Calendar.current.component(.day, from: date)

            let month = Calendar.current.component(.month, from: date)

            historico.append( "A Máquina foi quebrada em \(day) de \(month) as \(hour):\(minute)")

        } else

        {

            print("A Máquina Já está quebrada")

        }

    } 
}