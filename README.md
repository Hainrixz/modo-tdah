# modo-tdah

Una skill que le cambia la forma a la respuesta de tu asistente: la acción primero, los pasos numerados, sin preámbulo, sin recap y sin despedida.

## Crédito

Esta es la versión en español de [`i-have-adhd`](https://github.com/ayghri/i-have-adhd), de Ayoub G. ([@ayghri](https://github.com/ayghri)), publicada bajo licencia MIT. El ruleset original es suyo; acá está traducido y adaptado, no reinventado.

La diferencia real no es cosmética: las reglas 8 y 10 prohíben arranques y cierres concretos, y esos arranques y cierres están escritos en el idioma en el que el modelo responde. Prohibir "Great question!" no evita que te conteste "Buena pregunta". Por eso la lista negra de esta versión está en español: "Claro", "Voy a", "Déjame", "Espero que te sirva", "Cualquier cosa me dices".

## Instalación en Claude Code

```bash
claude plugin marketplace add Hainrixz/modo-tdah
claude plugin install modo-tdah@modo-tdah
```

Después escribe `/modo-tdah` y las reglas quedan encendidas para esa sesión. No hace falta clonar nada: Claude Code trae el repo y lo mantiene actualizado.

### Siempre encendido

Si no quieres escribir `/modo-tdah` cada vez, deja la bandera:

```bash
touch ~/.claude/.modo-tdah-always
```

Un hook de `SessionStart` carga el ruleset completo desde el primer mensaje de cada sesión. Para volver a que sea a pedido:

```bash
rm ~/.claude/.modo-tdah-always
```

El hook solo dispara si el archivo existe, así que instalar el plugin por sí solo no cambia nada. Respeta `$CLAUDE_CONFIG_DIR` si moviste tu carpeta de configuración.

## Instalación en Claude chat y en Cowork

Prerrequisito: activa **Ejecución de código y creación de archivos** en Configuración → Capacidades. Sin eso, la sección de Skills no aparece.

1. Baja `dist/modo-tdah.zip` de este repo.
2. Abre **Customize → Skills → «+» → Crear skill → Subir una skill**.
3. Sube el zip.

### Por qué el zip trae otro frontmatter

En Claude Code la skill se activa con el comando `/modo-tdah`, así que el `SKILL.md` del repo lleva `disable-model-invocation: true`: nadie la enciende salvo tú.

En el chat y en Cowork no hay comandos slash para skills. La única forma de que se active es que el modelo la invoque solo. Si el zip conservara esa línea, la skill quedaría instalada y correctamente listada, y no se dispararía nunca. Por eso la versión empaquetada la quita.

## Qué cambia

**Antes**

> Buena pregunta. Déjame revisar esto. Tu flujo de autenticación tiene varias piezas: el middleware, la verificación del token y el manejo de cookies. Viendo `src/auth.ts`, la función `verifyToken` (por las líneas 42 a 58) parece estar usando una API vieja de `jsonwebtoken`. Una opción sería actualizar el paquete y reescribir esa función. Después del cambio convendría correr las pruebas de auth para confirmar que nada se rompe. Por cierto, también valdría la pena revisar las versiones de tus dependencias en general. Espero que te sirva. Cualquier cosa me dices.

**Después**

> Corre `npm install jsonwebtoken@latest` y luego edita `src/auth.ts:42`.
>
> 1. Abre `src/auth.ts`
> 2. Reemplaza `verifyToken` (líneas 42 a 58) con el fragmento de abajo
> 3. Corre `npm test -- auth.spec.ts`
>
> Sigue: si falla alguna prueba, pega la primera línea del error.

## Las 10 reglas

El texto completo está en [skills/modo-tdah/SKILL.md](./skills/modo-tdah/SKILL.md), con las 6 excepciones y el chequeo previo al envío.

1. Empieza por la acción que sigue.
2. Numera el trabajo de varios pasos.
3. Cierra con una sola acción concreta.
4. Corta las tangentes: un tema a la vez.
5. Repite el estado en cada turno ("paso 3 de 5").
6. Estimaciones de tiempo en unidades concretas, nada de "un rato".
7. Deja visible lo que ya funciona.
8. Errores en tono seco: lugar, causa, arreglo.
9. Máximo 5 puntos por lista.
10. Sin preámbulo, sin recap, sin despedida.

## Cómo apagarlo

Escribe **"modo normal"**. También sirve "apaga el modo adhd". Se confirma en una línea y vuelve el estilo de siempre.

Si dejaste la bandera de siempre encendido, "modo normal" lo apaga solo en esa sesión. Para apagarlo de raíz, borra `~/.claude/.modo-tdah-always`.

## Guía completa

La explicación larga, con el porqué de cada regla y cómo adaptarla a tu forma de trabajar: <https://tododeia.com/community/modo-tdah-claude>

## Licencia

MIT. Ver [LICENSE](./LICENSE), que conserva íntegro el aviso de copyright del proyecto original.
