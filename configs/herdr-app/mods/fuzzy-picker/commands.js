import { commands, openOverlay, run, shared } from "herdr";

const choices = [
  ["pane.split", { direction: "right" }, "Split right"],
  ["pane.split", { direction: "down" }, "Split down"],
  ...["left", "down", "up", "right"].map((direction) =>
    ["pane.go", { direction }, `Focus pane ${direction}`]),
  ...["left", "down", "up", "right"].map((direction) =>
    ["pane.swap", { direction }, `Swap pane ${direction}`]),
  ["mod.open", { name: "picker" }, "Go to space or tab"],
];

const hidden = new Set([
  "pane.split", "pane.go", "pane.swap", "mod.open", "overlay.close",
  "app.palette",
]);

function title(name) {
  const [noun, verb] = name.split(".");
  const text = `${verb.replace(/_/g, " ")} ${noun}`;
  return text[0].toUpperCase() + text.slice(1);
}

export function commandSource() {
  const available = commands();
  const byName = new Map(available.map((command) => [command.name, command]));
  const entries = choices
    .filter(([name]) => byName.has(name))
    .map(([name, args, label]) => ({
      id: `${name}:${JSON.stringify(args)}`,
      label,
      detail: name,
      search: `${label} ${name} ${byName.get(name).about}`,
      select: () => run(name, args),
    }));

  for (const command of available) {
    if (hidden.has(command.name) || command.args.some((arg) => arg.required && arg.name !== "name")) continue;
    const label = title(command.name);
    entries.push({
      id: command.name,
      label,
      detail: command.name,
      search: `${label} ${command.name} ${command.about}`,
      select: () => {
        if (command.name === "layout.clone") {
          run("layout.clone", { name: shared("layout") ?? "main" });
        } else if (command.name === "mod.clone") {
          openOverlay({ mod: "prompt", kind: "dialog", width: 380, props: {
            title: "Duplicate mod", hint: "Mod to copy; creates <name>-copy",
            command: { name: "mod.clone", args: {} },
          } });
        } else {
          run(command.name);
        }
      },
    });
  }
  return entries;
}
