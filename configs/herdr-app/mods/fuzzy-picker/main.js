import { View, div } from "gpui-kit";
import { h_flex, v_flex, Input, InputState } from "gpui-base";
import { closeOverlay, exec, notify, props, theme } from "herdr";
import { commandSource } from "./commands.js";

const SHOWN = 10;
const FZF = `query=$1
delimiter=$2
shift 2
command -v fzf >/dev/null 2>&1 || exit 127
printf '%s\\0' "$@" | FZF_DEFAULT_OPTS= FZF_DEFAULT_OPTS_FILE= fzf --read0 --print0 --delimiter "$delimiter" --nth=2.. --filter="$query"`;

function score(query, text) {
  const target = text.toLowerCase();
  let at = 0;
  let total = 0;
  let previous = -2;
  for (const char of query) {
    const found = target.indexOf(char, at);
    if (found < 0) return null;
    total += 1 + (found === previous + 1 ? 3 : 0);
    if (found === 0 || /[\s._/-]/.test(target[found - 1])) total += 6;
    previous = found;
    at = found + 1;
  }
  return total - target.length * 0.01;
}

export default class FuzzyPicker extends View {
  init(_props, cx) {
    this.query = "";
    this.at = 0;
    this.revision = 0;
    this.results = commandSource();
    this.loading = false;
    this.fallbackNotified = false;
    this.handle = cx.focus_handle();
    this.input = InputState.new({ placeholder: "Find a command…" });
    this.input.on("change", (_event, cx) => {
      this.query = this.input.value();
      this.at = 0;
      this.search(cx);
      cx.notify();
    });
    this.input.on("submit", () => this.select(this.results[this.at]));
    this.input.focus();
    cx.timer.after(600, () => this.input.focus());
  }

  search(cx) {
    const revision = ++this.revision;
    const query = this.query;
    const entries = commandSource();
    if (!query.trim() || !entries.length) {
      this.loading = false;
      this.results = entries;
      return;
    }

    this.loading = true;
    cx.timer.after(120, (cx) => {
      if (revision !== this.revision) return;
      cx.spawn(async (cx) => {
        try {
          const input = entries.map((entry, index) => `${index}\t${entry.search}`);
          const result = await exec("sh", ["-c", FZF, "fuzzy-picker", query, "\t", ...input]);
          if (revision !== this.revision) return;
          if (result.code === 1) {
            this.results = [];
          } else if (result.code === 0) {
            this.results = result.stdout.split("\0").filter(Boolean).map((line) => {
              const separator = line.indexOf("\t");
              const id = line.slice(0, separator);
              const index = Number(id);
              if (separator < 1 || !/^\d+$/.test(id) || !Number.isInteger(index) || !entries[index]) {
                throw new Error("Invalid fzf result");
              }
              return entries[index];
            });
          } else {
            throw new Error(result.code === 127 ? "fzf is not installed" : `fzf exited with code ${result.code}: ${result.stderr}`);
          }
        } catch (error) {
          if (revision !== this.revision) return;
          this.results = this.fallback(entries, query);
          if (!this.fallbackNotified) {
            notify({ title: "Using built-in fuzzy search", body: String(error), level: "warning" });
            this.fallbackNotified = true;
          }
        }
        this.loading = false;
        cx.notify();
      });
    });
  }

  fallback(entries, query) {
    const normalized = query.toLowerCase().replace(/\s+/g, "");
    return entries
      .map((entry) => ({ entry, rank: score(normalized, entry.search) }))
      .filter((result) => result.rank !== null)
      .sort((a, b) => b.rank - a.rank)
      .map((result) => result.entry);
  }

  select(entry) {
    if (this.loading || !entry) return;
    closeOverlay(props().overlay);
    entry.select();
  }

  render() {
    const t = theme();
    const rows = this.results;
    this.at = Math.max(0, Math.min(this.at, rows.length - 1));
    const start = Math.max(0, Math.min(this.at - SHOWN + 1, rows.length - SHOWN));
    return v_flex()
      .id("fuzzy-picker")
      .track_focus(this.handle)
      .w_full().min_h(0).p(18).gap(10).bg(t.popover)
      .on_key_down((event, cx) => {
        const key = event.key;
        const control = event.modifiers.control && !event.modifiers.alt && !event.modifiers.platform;
        if (key === "escape") {
          closeOverlay(props().overlay);
        } else if (key === "down" || (control && key === "j")) {
          this.at = Math.min(this.at + 1, rows.length - 1);
        } else if (key === "up" || (control && key === "k")) {
          this.at = Math.max(this.at - 1, 0);
        } else {
          return;
        }
        cx.stop_propagation();
        cx.notify();
      })
      .child(h_flex().h(36).flex_none().px(10).items_center().rounded(9)
        .border_1().border_color(t.accent).bg(t.background)
        .child(Input.new(this.input).flex_1().h_full().text_size(13).text_color(t.foreground))
        .when(this.loading, (el) => el.child(div().text_size(11).text_color(t.dim).child("Searching…"))))
      .child(rows.length
        ? v_flex().children(rows.slice(start, start + SHOWN).map((entry, index) =>
          h_flex().id(`choice-${entry.id}`).h(32).px(10).gap(10).items_center()
            .rounded(7).cursor_pointer()
            .when(start + index === this.at, (el) => el.bg(t.selected))
            .hover((el) => el.bg(t.hover))
            .on_click(() => this.select(entry))
            .child(div().flex_1().truncate().text_size(13).text_color(t.foreground).child(entry.label))
            .child(div().text_size(11).text_color(t.dim).child(entry.detail))))
        : div().px(10).py(14).text_size(13).text_color(t.dim).child(this.loading ? "Searching…" : "No matches"));
  }
}
