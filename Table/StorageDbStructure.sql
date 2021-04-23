-- Table: public.storage

-- DROP TABLE public.storage;

CREATE TABLE public.storage
(
    name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    capacity double precision,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT storage_pkey PRIMARY KEY (name)
)

TABLESPACE pg_default;

ALTER TABLE public.storage
    OWNER to dbuser;