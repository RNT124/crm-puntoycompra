-- Punto y Compra (aplicado el 2026-11-10): código interno de SmartClic (CODIGOITEM)
alter table public.prendas add column if not exists codigo_interno text;
create unique index if not exists prendas_codigo_interno_key on public.prendas (codigo_interno) where codigo_interno is not null;
