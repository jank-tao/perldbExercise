-- Table: public.server

-- DROP TABLE public.server;

CREATE TABLE public.server
(
    name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    operating_system character varying(25) COLLATE pg_catalog."default" DEFAULT 'Linux'::character varying,
    storage_name character varying(25) COLLATE pg_catalog."default",
    checksum character varying(50) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT server_pkey PRIMARY KEY (name),
    CONSTRAINT fk_name FOREIGN KEY (storage_name)
        REFERENCES public.storage (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.server
    OWNER to dbuser;