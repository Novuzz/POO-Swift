protocol Manutencao {
    let id: String
    var nome: String
    var historico: [String]

    func reparar() -> Bool;
    func emDia() -> Bool;
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