CREATE OR REPLACE FUNCTION prevent_deletion()
RETURNS trigger AS $$
BEGIN
  RAISE EXCEPTION 'Deletion not allowed on this table.';
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_delete_trigger
BEFORE DELETE ON covid_data
FOR EACH ROW
EXECUTE FUNCTION prevent_deletion();
