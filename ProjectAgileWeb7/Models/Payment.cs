using System;

namespace ProjectAgileWeb7.Models
{
    public enum PaymentMethod { Card, Cash, Other }
    public class Payment
    {
        public int Id { get; set; }
        public Status Status { get; set; }
        public DateTime Date { get; set; }
        public decimal Amount { get; set; }
        public PaymentMethod Method { get; set; }
        public long CardNumber { get; set; }
        public int CVV { get; set; }
        public string CardHolderFirstName { get; set; }
        public string CardHolderLastName { get; set; }
        public string BankAndClearing { get; set; }
    }
}