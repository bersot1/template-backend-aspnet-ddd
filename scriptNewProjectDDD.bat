@echo off
cls
echo.
echo.
echo Entry with your Project Name: (please, do not use special carecter)
echo.
set /p projetName=Project Name:
echo.
mkdir "%projetName%"
cd "%projetName%"
mkdir "%projetName%".Domain
mkdir "%projetName%".Domain.Infra
mkdir "%projetName%".Domain.Tests
mkdir "%projetName%".Domain.Api
cd "%projetName%".Domain
dotnet new classlib
cls
cd ..
cd "%projetName%".Domain.Api
dotnet new webapi
cls
cd ..
cd "%projetName%".Domain.Infra
dotnet new classlib
cls
cd ..
cd "%projetName%".Domain.Tests
dotnet new mstest
cls
cd ..
dotnet new sln
dotnet sln add ./"%projetName%".Domain
dotnet sln add ./"%projetName%".Domain.Api\
dotnet sln add ./"%projetName%".Domain.Tests\
dotnet sln add ./"%projetName%".Domain.Infra\
cls
dotnet build
cd ./"%projetName%".Domain.Api
dotnet add reference ../"%projetName%".Domain
dotnet add reference ../"%projetName%".Domain.Infra
cd ..
cd ./"%projetName%".Domain.Infra
dotnet add reference ../"%projetName%".Domain
cd ..
cd ./"%projetName%".Domain.Tests
dotnet add reference ../"%projetName%".Domain
cd ..
cd ./"%projetName%".Domain
dotnet add package Flunt
mkdir Commands
cd ./Commands
mkdir Contracts
cd ./Contracts
echo using Flunt.Validations;namespace %projetName%.Domain.Commands.Contracts{public interface ICommand : IValidatable{}} > ICommand.cs
echo namespace %projetName%.Domain.Commands.Contracts{public interface ICommandResult{}} > ICommandResult.cs
cd ../
echo using %projetName%.Domain.Commands.Contracts;namespace %projetName%.Domain.Commands{public class GenericCommandResult : ICommandResult{/*TOdo nosso retorno que vai sair do nosso Handerls vai ser retornado para o front endcomo um genericCommandResult*/public GenericCommandResult() { }public GenericCommandResult(bool sucess, string message, object data){Sucess = sucess;Message = message;Data = data;}public bool Sucess { get; set; }public string Message { get; set; }public object Data { get; set; }}} > GenericCommandResult.cs
echo using System;using Flunt.Notifications;using Flunt.Validations;using %projetName%.Domain.Commands.Contracts;namespace %projetName%.Domain.Commands{public class ExampleCreateSomethingCommand : Notifiable, ICommand {public ExampleCreateSomethingCommand() { }public ExampleCreateSomethingCommand(string title, string user, DateTime date){Title = title;User = user;Date = date;}public string Title { get; set; }public string User { get; set; }public DateTime Date { get; set; }public void Validate(){AddNotifications(new Contract().Requires().HasMinLen(Title, 3, "Title", "Por favor, descreva melhor esta tarefa!").HasMinLen(User, 6, "User", "Usuário inválido!"));}}} > ExampleCreateSomenthingCommand.cs
cd ../
mkdir Entities
cd ./Entities
echo using System;namespace %projetName%.Domain.Entities{public abstract class Entity : IEquatable--Entity--{public Entity(){Id = Guid.NewGuid();}public Guid Id { get; private set; }public bool Equals(Entity other){return Id == other.Id;}}} > Entity.cs
echo using System;namespace %projetName%.Domain.Entities{public class ExampleEntity: Entity{public ExampleEntity(string title, string user, DateTime date){Title = title;Done = false;Date = date;User = user;}public string Title { get; private set; }public bool Done { get; private set; }public DateTime Date { get; private set; }public string User { get; private set; }public void MaskAsDone(){Done = true;}public void MaskAsUndone(){Done = false;}public void UpdateTitle(string title){Title = title;}}} > ExampleEntity.cs
cd ../
mkdir Handlers
cd ./Handlers
mkdir Contracts
cd ./Contracts
echo using %projetName%.Domain.Commands.Contracts;namespace %projetName%.Domain.Handlers.Contracts{public interface IHandle--T-- where T : ICommand{ICommandResult Handle(T command);}} > IHandler.cs
cd ..
echo using Flunt.Notifications;using %projetName%.Domain.Commands;using %projetName%.Domain.Commands.Contracts;using %projetName%.Domain.Entities;using %projetName%.Domain.Handlers.Contracts;using %projetName%.Domain.Repositories;namespace %projetName%.Domain.Handlers{public class ExampleHandler:Notifiable,IHandle--ExampleCreateSomethingCommand--{private readonly IExampleRepository _repository;public ExampleHandler(IExampleRepository repository){repository = _repository;}public ICommandResult Handle(ExampleCreateSomethingCommand command){command.Validate();if (command.Invalid){return new GenericCommandResult(false,"Ops, parece que sua tarefa está errada",command.Notifications);}var todo = new ExampleEntity(command.Title, command.User, command.Date);_repository.Create(todo);return new GenericCommandResult(true,"Sucesso",todo);}}} > ExampleHandler.cs
cd ..
mkdir Repositories
cd ./Repositories
echo using %projetName%.Domain.Entities;namespace %projetName%.Domain.Repositories{public interface IExampleRepository{void Create(ExampleEntity todo);void Update(ExampleEntity todo);}} > IExampleRepository.cs
cd ..
