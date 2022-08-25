/*Retornar a data de alguel:
Aqui selecionamos a tabela RENTAL onde data de aluguel seja entre os dia 20/05/2005 ao dia 27/05/2005 */
select * from rental where rental_date between '20050520' AND '20050527';

-- retornando apenas os ratings (avaliações) de filmes existentes;
select rating as Avaliação from film group by rating;

-- Retorna resultando da query pagamento se a subquery tiver algum resultado ou seja, seja verdadeira
select * from payment as p
where exists (
	select s.username from staff as s
    where s.staff_id = p.staff_id 
);

-- Retorna a cidade de 3 paises, emulando o intersect
select * from city as ci -- selecionando todas as cidades do pais
where country_id  in ( -- onde o pais ID esteja no retorno da subquery
	select country_id from country as coun -- esse select retornara os id dos paises listados no in
		where country in ('Brazil', 'Argentina', 'Bulgaria')
);

-- exibindo os resultados da tabela customer onde email começe com lisa
select * from customer where email like "lisa%";

-- Retornando o funcionario que alugou, o cliente que pagou o e-mail dele, o valor e a data de pagamento
select sta.first_name as staff, c.first_name as customer, c.email, pay.amount, pay.payment_date
from staff as sta
	inner join payment as pay on sta.staff_id = pay.staff_id
	inner join customer as c on c.customer_id = pay.customer_id;
    
-- alterando a a coluna city da tabela City e modificando os caracteres que ela irá receber para 100.
select * from city;
Alter table city
modify city varchar (100);

select * from actor;
/* Primeiro selecionei da tabela ACTOR o primeiro e o ultimo nome do ID 168 > Will Wilson
	depois fiz o segundo select da mesma tabela onde o primeiro nome começasse com Penelope e junto com seu ultimo nome
    e fiz a união dessas duas tabelas:
*/
select first_name, last_name from actor
where actor_id = 168 union 
select first_name, last_name from actor where first_name = 'Penelope';

-- Aqui retorna os resultados de duas queries, a diferença é que o UNION ALL mantém os valores duplicados de cada SELECT.
select first_name, last_name from actor
union all
select first_name, last_name from actor;

-- Exibindo os resultados da tabela Film > quantos filmes possuem a Avaliação maior que 200;
select rating as Avaliação, count(film_id) as Quantidade_filmes 
from film 
group by rating -- agrupando a coluna Avaliação 
having count(film_id) > 200; -- condição

-- retornar o id de pagamento e a quantia da tabela Pagamentos onde a quantia seja maior que 5.99 ordenado de forma crescente;
select payment_id, amount from payment where amount > 5.99 order by amount asc;

/*
  Retornando o primeiro nome dos Atores de cada filme
  Apelido da tabela ACTOR > a.; Apelido da tabela FILM > f.; Apelido da tabela de relacionamento > fa.
*/
select f.title, a.first_name -- atributos das tabelas
from film as f
left join film_actor as fa -- tabela de relação e apelido
	on f.film_id = fa.film_id -- film_id tem nas tabelas film_actor e film por isso se relacionam
left join actor as a 
	on fa.actor_id = a.actor_id;  -- actor_id tem nas tabelas film_actor e actor por isso se relacionam
    
/*Retorne tabela de relação de filmes com categoria*/
select * from film_category;
-- retornando apenas o identificador de categoria de filmes sem repetição
select distinct category_id
from film_category;

-- retornando da tabela Staff > onde funcionários que não tenham foto.
select * from staff where picture is null;

/* selecionando da tabela country (Paises) os seus paises e fazendo um cruzamento com a tabela city (cidades),
 trazendo as cidades dos seus respectativos paises.*/
select cr.country as pais, ci.city as cidade 
from country as cr -- "apelido" cr da tabela country
cross join city as ci -- "apelido" ci da tabela city
	on cr.country_id = ci.country_id; -- relacionei os campos em comum das duas tabelas que seria o country_id

/* Aqui retorna os resultando do Film1 que tenham o mesmo tamanho do Filme2, relacionando com o Self join as colunas da mesma tabela*/
select f1.title as titulo_film1, f1.length as tamanho_film1, f2.title as titulo_film2, f2.length as tamanho_film2 -- "apelindo os nomes da tabela"
from film as f1
inner join film as f2 -- relacionando na mesma tabela
	on f1.film_id <> f2.film_id -- em que film_id do 1° relacionamento seja diferente do film_id do 2° relacionamento
    where f1.length = f2.length; -- onde tamanho do film 1 seja igual o tamanho do film 2;

-- selecionando da tabela Customwe o last_name onde Maritin e o primeiro Sandra esteja, na mesma linha
select * from customer where last_name = 'MARTIN' and first_name = 'SANDRA';

-- selecionando da tabela Customer onde o last_name seja Martini ou o primeiro nome seja Jessica, aqui o resultando não precisa ser na mesma linha
select * from customer where last_name = 'MARTIN' or  first_name = 'JESSICA';

-- Selecionei da tabela FILM as colunas title, description e rating os resultandos ONDE a Avaliação (rating) não seja PG-13 e NC=17
select title, description, rating from film where rating not in ('PG-13', 'NC-17');
-- ******
-- Aqui selecionamos a tabela film onde retorne o tempo de aluguel de 3 e 6 meses, em ordem crescente;
select * from film where rental_duration between '3' AND '6' order by  rental_duration asc;

-- agrupando apenas a coluna "duração de aluguel" da tabela film;
select rental_duration as rt from film group by rental_duration;

-- exibindo resultados da tabela film em que vá do 0 ao 30;
select * from film limit 30;

-- retornando da tabela pagamentos onde mostre apenas a quantia igual a 4.99
select * from payment where amount = 4.99;

-- exibindo resultados da tabela film_text em ordem crescente os titulos de 0 a 10;
select * from film_text order by title asc limit 15, 30;

-- retornando da tabela Customer >  e-mail de clientes que sejam nulos;
select * from customer where email is null;

-- Agrupando da tabela filme a coluna Custo de Reposição em ordem decrescente
select * from film group by replacement_cost order by replacement_cost desc;

/*select * from customer;
select * from rental;*/

-- retornando todos os rental em que o staff_id seja diferente de 2 (emulando o MINUS com NOT IN numa subquery)
select * from rental -- selecionando todos os rental id que não estejam no resultado da subquery
where rental_id not in ( -- not in nos rental id do select abaixo
	select rental_id from rental -- esse select retornara todos os rental com staff_id 2
		where staff_id = 2 
);

-- exibindo os resultando da tebela Country onde country se inicie com "BR"
select * from country where country like "BR%";

-- exibindo os resultando da tebela Country onde retorne apenas os 3 paises;
select * from country where country in  ('Brazil', 'Argentina', 'Bulgaria');

-- exibindo os resultados da tabela customer onde retorne os last_name que não sejam Collins
select * from customer where last_name <> "COLLINS";

-- agrupando apenas a coluna "duração de aluguel" da tabela film;
select rental_duration as rt from film group by rental_duration;
