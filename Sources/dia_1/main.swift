
enum Experiencia : String
{
    case iniciante = "Iniciante"
	case intermediario = "Intermediário"
	case avancado = "Avançado"
}
enum Aula : String
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