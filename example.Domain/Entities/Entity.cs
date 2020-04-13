using System;

namespace Todo.Domain.Entities
{

    // usamos classe abstract quando temos a intenção de 
    // inibir o instanciamento dessa classe. Ela vai ser 
    // semente herdada. e não instanciada.
    public abstract class Entity : IEquatable<Entity>
    {

        // existe 3 modificadores de classes: Protected, private e public
        // public - todas as classes tem acesso
        // protected - somente os filhos tem acesso
        // private - somente a mesma tem acesso a ela.
        public Entity()
        {
            Id = Guid.NewGuid();
        }

        // usamos essa classe generica para atributos que são
        // genéricos de 1 ou mais entidades, nesse exemplo, toda entidade,
        // precisará de um ID, ou seja, toda as entidades vao extender essa Entity

        // Utilizamos o private set para determinar que somente 
        // esta classe entity tem direito de setar o id. Nenhuma outr classe
        // ou metodo poderá mexer nessa propriedade.
        public Guid Id { get; private set; }

        public bool Equals(Entity other)
        {
            // para fazer uma comparação e evitar que uma entidade seja igual a outra
            // usamos essa IEquatable<entity> que vai permitir essa comparação;

            return Id == other.Id;
        }
    }
}