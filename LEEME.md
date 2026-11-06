# Plantilla CRM de ventas de ropa (para replicar a otras marcas)

CRM de un solo archivo (`index.html`) + base de datos Supabase + publicación gratis en GitHub Pages.
Nació para vender ropa por live (TikTok) con envíos por motorizado y Shalom en Perú.

## Qué hay aquí
| Archivo | Para qué |
|---|---|
| `index.html` | Todo el CRM (pantallas, lógica, enlaces públicos para clientas) |
| `schema_base.sql` | Crea TODAS las tablas, relaciones, cálculos automáticos y permisos. Sin datos. |
| `PROMPT_INICIO.md` | Prompt para abrir un chat nuevo de Claude y adaptar el CRM a la nueva marca |
| `LEEME.md` | Esta guía |

## Alta de una clienta nueva (siempre el mismo proceso)
1. **Supabase de ELLA:** ella crea su cuenta y su proyecto (región South America / São Paulo) y te invita como miembro (Organization → Team → Invite). El **código vive en TU GitHub**.
2. **GitHub (tuyo):** repo nuevo `crm-[marca]` a partir de esta plantilla ("Use this template"), público (necesario para Pages gratis).
3. **Supabase (de ella):** en su proyecto → SQL Editor → pegar `schema_base.sql` → antes cambiar `'PED'` por 3 letras de su marca → Run.
4. **Configuración:** en `index.html`, SOLO el bloque `CONFIG` del inicio del script:
   marca, WhatsApp, URL del repo, URL y llave de Supabase (Project Settings → API), tarifa de motorizado, canales.
5. **Usuarios:** cambiar `USERS` (usuarios y contraseñas). NUNCA dejar las de ejemplo.
6. **Marca visual:** buscar `TU MARCA` / `Tu Marca` / `tumarca.pe` y reemplazar; pegar su logo (PNG base64) en `BR_LOGO_B64` para las etiquetas; revisar colores.
7. **Publicar:** GitHub → Settings → Pages → rama `main`, carpeta `/ (root)`.
8. **Probar de punta a punta:** crear una prenda, una clienta, un pedido de prueba, un despacho y una etiqueta. Luego borrar los datos de prueba.

## Qué es de Jassmin y hay que revisar para cada marca
- Reglas de envío: motorizado a tarifa fija (`CONFIG.ENVIO_MOTORIZADO`, aunque algunos textos dicen "S/ 14"), Shalom pagado en agencia.
- Módulo **Brasil** (compras en reales, tasa fija): es opcional; si la marca no importa de Brasil, ocultar esa pestaña.
- Mensajes de WhatsApp, términos y condiciones, textos de la página de registro: reescribirlos con la voz de la marca.
- Cobros: el CRM asume Yape / Plin / Transferencia.

## Seguridad (importante antes de vender a terceras)
- El CRM usa la base de datos **sin RLS** y con la llave pública; los usuarios del login están escritos en el código.
  Para uso propio es aceptable; para vender, endurecer con inicio de sesión real y RLS (fase aparte).
- No subir a GitHub claves secretas (`service_role`). La llave "publishable" sí es pública por diseño.
- Cada clienta es dueña de sus datos: cuenta propia de Supabase.
- Los datos personales (DNI, teléfonos) están sujetos a la ley de protección de datos de Perú: revisar el contrato con un abogado.

## Costos de Supabase (verificar en supabase.com/pricing)
Gratis: 2 proyectos activos, 500 MB, se **pausa tras 1 semana sin uso**, sin copias de seguridad.
Pro: desde US$ 25 al mes, sin pausa, copias diarias.
