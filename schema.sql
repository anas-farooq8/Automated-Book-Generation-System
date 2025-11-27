-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.books (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  title text NOT NULL,
  notes_on_outline_before text,
  notes_on_outline_after text,
  status_outline_notes text DEFAULT 'no'::text,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT books_pkey PRIMARY KEY (id)
);
CREATE TABLE public.chapters (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  book_id uuid,
  outline_id uuid,
  chapter_number integer NOT NULL,
  chapter_title text,
  description text,
  content text,
  summary text,
  chapter_notes text,
  chapter_notes_status text DEFAULT 'no'::text,
  status text DEFAULT 'pending'::text,
  version integer DEFAULT 1,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT chapters_pkey PRIMARY KEY (id),
  CONSTRAINT chapters_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id),
  CONSTRAINT chapters_outline_id_fkey FOREIGN KEY (outline_id) REFERENCES public.outlines(id)
);
CREATE TABLE public.outlines (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  book_id uuid,
  outline_json jsonb,
  version integer DEFAULT 1,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT outlines_pkey PRIMARY KEY (id),
  CONSTRAINT outlines_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id)
);