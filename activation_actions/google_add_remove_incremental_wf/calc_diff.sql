SELECT * FROM (
  SELECT DISTINCT
    '${session_id}' as session_id,
    '${attempt_id}' as attempt_id,
    CASE
      WHEN h.${JSON.parse(result_connection_settings).identifier_type=='contact_info' ? 'email' : 'mobile_id'} IS NULL THEN 'add'
      WHEN a.${JSON.parse(result_connection_settings).identifier_type=='contact_info' ? 'email' : 'mobile_id'} IS NULL THEN 'delete'
      ELSE '???' -- no change or modified
    END as change
    , coalesce(h.${JSON.parse(result_connection_settings).identifier_type=='contact_info' ? 'email' : 'mobile_id'}, a.${JSON.parse(result_connection_settings).identifier_type=='contact_info' ? 'email' : 'mobile_id'}) as ${JSON.parse(result_connection_settings).identifier_type=='contact_info' ? 'email' : 'mobile_id'}
    --, h.*
    --, a.*
  FROM
    previous_profiles_syndication_${activation_id} h
    FULL OUTER JOIN ${activation_actions_table} a
    ON h.${JSON.parse(result_connection_settings).identifier_type=='contact_info' ? 'email' : 'mobile_id'} = a.${JSON.parse(result_connection_settings).identifier_type=='contact_info' ? 'email' : 'mobile_id'}
)
--WHERE  change <> '???'
;