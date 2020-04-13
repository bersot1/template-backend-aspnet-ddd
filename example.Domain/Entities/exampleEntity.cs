using System;

namespace Todo.Domain.Entities
{
    public class TodoItem : Entity
    {
        public TodoItem(string title, string user, DateTime date)
        {
            Title = title;
            Done = false;
            Date = date;
            User = user;
        }

        public string Title { get; private set; }

        public bool Done { get; private set; }

        public DateTime Date { get; private set; }
        public string User { get; private set; }
        // o user está tipado com "string" pois a nossa verificação
        // vai acontecer no google. Então so teremos a referencia dele


        // já que nossa classe tem as propriedades de set privadas,
        // temos que adicionar metodos aqui para atualizarmos a nossa instancia desse objeto.

        public void MaskAsDone()
        {
            Done = true;
        }

        public void MaskAsUndone()
        {
            Done = false;
        }

        public void UpdateTitle(string title)
        {
            Title = title;
            // Nota-se que não estamos usando nennhum tipo de validação aqui
            // isso ocorre pq nossa validação fica no comandas, pois
            // usamos o conceito fast fail validation, para diminuirmos
            // os nossos codigos nos dominios
        }


    }
}