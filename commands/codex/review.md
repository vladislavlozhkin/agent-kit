---
description: Code review через Codex
argument-hint: [--uncommitted | --base <branch>] [инструкции]
---

## Использование

Выполнить code review через скрипт с логированием:

```bash
.claude/scripts/codex/review.sh $ARGUMENTS
```

Скрипт автоматически:
- Создаёт лог-файл в `.claude/logs/codex/review/`
- Записывает аргументы и результат ревью
- Обновляет symlink `latest.md`

## Флаги

| Флаг | Описание |
|------|----------|
| `--uncommitted` | Staged, unstaged и untracked изменения |
| `--base <branch>` | Изменения относительно указанной ветки |

## Примеры

```
/codex:review --uncommitted
/codex:review --base main
/codex:review --base main проверь безопасность
```
