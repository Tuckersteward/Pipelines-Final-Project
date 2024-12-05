-- Replace 'public' with your schema name
DO $$ 
DECLARE
    drop_tables_query TEXT;
    drop_sequences_query TEXT;
    drop_views_query TEXT;
    drop_schema_query TEXT;
    create_schema_query TEXT;
BEGIN
    drop_tables_query := (
        SELECT COALESCE(string_agg(format('DROP TABLE IF EXISTS %I.%I CASCADE;', schemaname, tablename), ' '), '')
        FROM pg_tables
        WHERE schemaname = 'public'
    );
    IF drop_tables_query != '' THEN
        EXECUTE drop_tables_query;
    END IF;

    drop_sequences_query := (
        SELECT COALESCE(string_agg(format('DROP SEQUENCE IF EXISTS %I.%I CASCADE;', sequence_schema, sequence_name), ' '), '')
        FROM information_schema.sequences
        WHERE sequence_schema = 'public'
    );
    IF drop_sequences_query != '' THEN
        EXECUTE drop_sequences_query;
    END IF;

    drop_views_query := (
        SELECT COALESCE(string_agg(format('DROP VIEW IF EXISTS %I.%I CASCADE;', schemaname, viewname), ' '), '')
        FROM pg_views
        WHERE schemaname = 'public'
    );
    IF drop_views_query != '' THEN
        EXECUTE drop_views_query;
    END IF;

    drop_schema_query := format('DROP SCHEMA IF EXISTS %I CASCADE;', 'public');
    EXECUTE drop_schema_query;

    create_schema_query := format('CREATE SCHEMA IF NOT EXISTS %I;', 'public');
    EXECUTE create_schema_query;

END $$;
