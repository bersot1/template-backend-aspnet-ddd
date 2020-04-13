using Todo.Domain.Commands.Contracts;

namespace Todo.Domain.Commands
{

    public class GenericCommandResult : ICommandResult
    {
        // TOdo nosso retorno que vai sair do nosso 
        // Handerls vai ser retornado para o front end
        // como um genericCommandResult

        public GenericCommandResult() { }
        public GenericCommandResult(bool sucess, string message, object data)
        {
            Sucess = sucess;
            Message = message;
            Data = data;
        }

        public bool Sucess { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }

    }

}