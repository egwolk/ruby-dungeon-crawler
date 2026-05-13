# Ruby Dungeon Crawler

Simple terminal dungeon crawler written in Ruby. Players move through rooms, fight randomly generated enemies, and manage an inventory.

## Run

Requires Ruby. From the project root run:

```bash
ruby main.rb
```

## Controls
- Press ENTER to continue when prompted.
- Battle menu: `1` Attack, `2` Inventory, `3` Run, `4` Give Up.
- Inventory: use number keys to select items, then follow the prompts.

## Files
- `main.rb` — game loop and startup ([main.rb](main.rb#L1)).
- `player.rb` — player model and stats ([player.rb](player.rb#L1)).
- `enemy.rb` — enemy definitions and scaling ([enemy.rb](enemy.rb#L1)).
- `battle.rb` — battle flow and input handling ([battle.rb](battle.rb#L1)).
- `battle_combat.rb` — attack/run logic ([battle_combat.rb](battle_combat.rb#L1)).
- `inventory.rb` / `item.rb` — inventory and item data ([inventory.rb](inventory.rb#L1), [item.rb](item.rb#L1)).

## Assignment concept mapping

- **A. Data types:**
  - Integer: `hp`, `atk` (`player.rb`, `enemy.rb`).
  - Float: `crit`, `luck`, item value scaling (`player.rb`, `item.rb`).
  - String: `name` (`enemy.rb`, `item.rb`).
  - Boolean: `equipped` (`item.rb`, `inventory.rb`).
- **B. Operators:**
  - Assignment: `@player.hp = ...` used throughout (e.g. `battle_items.rb`).
  - Arithmetic: `+`, `-`, `*` used in damage and stat scaling (`battle_combat.rb`, `item.rb`).
  - Relational: `<=`, `>`, `==` used for HP and menu checks (`battle.rb`, `battle_combat.rb`).
  - Logical: `&&`, `||` used in guards and fallbacks (`inventory.rb`, `battle_inventory.rb`).
- **C. Control structures:**
  - Selection: `if`/`else`, `case` used in loot grading and menus (`battle_combat.rb`).
  - Iteration: `loop do`, `each_with_index` used for the main game loop and inventory listing (`battle.rb`, `inventory.rb`).
- **D. Subprograms:**
  - Methods: `player_attack`, `enemy_attack`, `attempt_run` in `battle_combat.rb`.
  - Parameterized/returning methods: `Battle#initialize(player, enemy, room)` accepts parameters; `attempt_run` returns boolean; `Inventory#add_item` returns boolean.

## GROUP MEMBERS
- Erin Drew C. Covacha [@egwolk](https://www.github.com/egwolk)
- William Rap-El O. Ragel [@rap-el](https://www.github.com/rap-el)
- Stephen Ezekiel C. Robles [@tpen14](https://www.github.com/tpen14)