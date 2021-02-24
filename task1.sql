--считаю что только Customer =2, полностью оплатил заказы
select c.id as customer_id, c.name as customer_name
     ,o.slide_order_summ
     ,p.paymet

  from customers c
  join (
         select oo.customerId
         ,oo.id
         ,oo.summa
         , v.slide_order_summ
           from orders oo
          cross apply 
                (
                  select sum(summa) as slide_order_summ
                    from orders o1
                  where oo.customerId = o1.customerId
                ) v
       )o
      on c.id = o.customerId
  join payments p
    on c.id = p.customerId

 where o.slide_order_summ <= p.paymet
group by c.id,c.name,o.slide_order_summ,p.paymet


 

