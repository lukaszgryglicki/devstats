create temp table matching as select event_id from gha_texts where substring(body from '(?i)(?:^|\n|\r)\s*/lgtm\s*(?:\n|\r|$)') is not null;
select
  count(distinct actor_id)
from
  gha_events
where
  dup_actor_login not in ('googlebot')
  and dup_actor_login not like 'k8s-%'
  and id in (
    select min(event_id)
    from
      gha_issues_events_labels
    where
      label_name in ('lgtm', 'Lgtm', 'lGtm', 'lgTm', 'lgtM', 'LGtm', 'LgTm', 'LgtM', 'lGTm', 'lGtM', 'lgTM', 'LGTm', 'LGtM', 'LgTM', 'lGTM', 'LGTM')
    group by
      issue_id
    union select event_id from matching
  );
drop table matching;