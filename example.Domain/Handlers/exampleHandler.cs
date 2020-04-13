using Flunt.Notifications;
using Todo.Domain.Commands;
using Todo.Domain.Commands.Contracts;
using Todo.Domain.Entities;
using Todo.Domain.Handlers.Contracts;
using Todo.Domain.Repositories;

namespace Todo.Domain.Handlers
{
    public class TodoHandler :
        Notifiable,
        IHandle<CreateTodoCommand>
    {

        private readonly ITodoRepository _repository;

        public TodoHandler(ITodoRepository repository)
        {
            repository = _repository;
        }
        public ICommandResult Handle(CreateTodoCommand command)
        {
            command.Validate();
            if (command.Invalid)
            {
                return new GenericCommandResult(
                    false,
                    "Ops, parece que sua tarefa está errada",
                    command.Notifications);
            }

            var todo = new TodoItem(command.Title, command.User, command.Date);

            _repository.Create(todo);

            return new GenericCommandResult(
                true,
                "Sucesso",
                todo
            );
        }
    }
}