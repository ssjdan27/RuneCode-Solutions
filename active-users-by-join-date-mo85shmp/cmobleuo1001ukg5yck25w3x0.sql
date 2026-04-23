select id, joined_at, name
from users
where is_active = '1'
order by joined_at