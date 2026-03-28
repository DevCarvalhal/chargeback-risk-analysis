-- Chargeback rate per customer
select
    customer_id,
    count(*) as total_transactions,
    sum(case when chargeback = 1 then 1 else 0 end) as total_chargebacks,
    round(
        100.0 * sum(case when chargeback = 1 then 1 else 0 end) / count(*),
        2
    ) as chargeback_rate_pct
from transactions
group by customer_id
having count(*) >= 5
order by chargeback_rate_pct desc;

-- Estimated financial loss by customer
select
    customer_id,
    sum(case when chargeback = 1 then amount else 0 end) as total_loss
from transactions
group by customer_id
order by total_loss desc;