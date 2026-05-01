
enum Experiencia : String
{
    case iniciante = "Iniciante"
	case intermediario = "Intermediário"
	case avancado = "Avançado"
}
enum Categoria : String
{
    case musculacao = "Musculação"
    case spinning  = "Spinning"
    case yoga = "Yoga"
    case funcional = "Funcional"
    case luta = "Luta"
}

enum TipoPlano : String
{
    case mensal = "Mensal"
    case trimestral = "Trimestral"
    case anual = "Anual"
}

class Plano
{
    private(set) let nome: String
    private(set) let valor: Double
    private(set) let tipo: TipoPlano
    private(set) var personal: Instrutor
    private(set) var horario: String

    
    init(nome: String, tipo: TipoPlano)
    {
        self.nome = nome
        self.tipo = tipo
        valor = 120
    }
    init(nome: String, tipo: TipoPlano, instrutor: Bool, horario: String)
    {
        self.nome = nome
        self.tipo = tipo
        valor = 120
        if(instrutor)
        {
            //Supondo que ele pegue de um banco de dados com o horario
            personal = Instrutor(nome: "Aleatório", email: "aleatorio@gmail.com", horarios: [horario])
            horario = self.horario
        }
    }
}

class Pessoa
{
    private(set) let nome: String
    private(set) let email: String
    
    init(nome: String, email: String, plano: Plano)
    {
        self.nome = nome
        self.email = email
    }
}

class Aluno : Pessoa
{
    
    private(set) var experiencia: Experiencia
    private(set) let inscricoes: Set<String>
    private(set) var plano: Plano
    
    init()
    {
        self.plano = plano
        experiencia = Experiencia.iniciante
    }
}

class Instrutor : Pessoa
{
    private(set) var horarios: Set<String>
    init(horarios: Set<String>)
    {
        self.horarios = horarios
    }
}
protocol Manutencao {
    let id: String
    var nome: String
    var historico: [String]

    func reparar() -> Bool;
    func emDia() -> Bool;
}

protocol Aula {
    let nome: String
    let categoria: Categoria
    let instrutor: Instrutor
    let descricao: String
}

class TreinoPersonal: Aula
{
    let nome: String
    let categoria: Categoria
    let instrutor: Instrutor
    let descricao: String
}

class TreinoColetivo: Aula
{
    let nome: String
    let categoria: Categoria
    let instrutor: Instrutor
    let descricao: String
}

class Maquina : Manutencao
{
    let id: String
    private(set) var nome: String
    private(set) var historico: [String] = []
    private(set) var estaFuncionando: Bool = true

    init(nome: String)
    {
        id = String(Int.random(1000, 19999))
        self.nome = nome
    }

    func reparar() -> Bool {
        if estaFuncionando
        {
            print("A Máquina Está em ordem")
        } else
        {
            print("A Máquina necessita de reparos")
        }
        return estaFuncionando
    }
    func emDia() -> Bool {
        return estaFuncionando
    }
}