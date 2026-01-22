# 📋 JetBrains IDE Manager – Install & Remove JetBrains IDEs on Linux

This repository provides a Bash-based **JetBrains IDE Manager** to easily **install** and **uninstall** JetBrains IDEs on Linux systems using a single interactive interface.

Supported IDEs include:

* IntelliJ IDEA Ultimate
* PyCharm Professional
* GoLand
* RubyMine

You can install, uninstall, or manage them individually or all at once.

---

## 🛠️ Features

* Interactive terminal menu (Install / Uninstall / Exit)
* Choose which IDE(s) to process
* Sudo authentication with keep-alive
* Colored output + spinner UI
* Modular structure (`apps/<ide>/install.sh`, `apps/<ide>/uninstall.sh`)

---

## 📥 Requirements

* Linux (Ubuntu/Debian recommended)
* `sudo` privileges
* Internet connection
* `curl`, `tar`, `gtk-update-icon-cache`, `update contando?

Wait finish doc.

Continue.


Perfeito, Ruan 😄
Aqui está a **versão atualizada em inglês**, já alinhada com o conceito do teu **JetBrains IDE Manager (`src/main.sh`)** 👇

---

# 📋 JetBrains IDE Manager – Install & Remove JetBrains IDEs on Linux

This repository provides a Bash-based **JetBrains IDE Manager** to easily **install** and **uninstall** JetBrains IDEs on Linux systems using a single interactive interface.

Supported IDEs:

* IntelliJ IDEA Ultimate
* PyCharm Professional
* GoLand
* RubyMine

You can manage them individually or all at once.

---

## 🛠️ Features

* Interactive terminal menu (Install / Uninstall / Exit)
* Choose which IDE(s) to process
* Sudo authentication with keep-alive
* Modular structure:
  `apps/<ide>/install.sh` and `apps/<ide>/uninstall.sh`
* Colored output, icons and spinner UI
* Automatic `.desktop` integration and command-line launchers

---

## 📥 Requirements

* Linux (Ubuntu/Debian recommended)
* `sudo` privileges
* Internet connection
* Tools: `bash`, `curl`, `tar`, `gtk-update-icon-cache`, `update-desktop-database`

---

## 🚀 Usage

### 1️⃣ Clone the repository

```bash
git clone https://github.com/your-user/jetbrains-ide-manager.git
cd jetbrains-ide-manager
```

### 2️⃣ Give execution permission

```bash
chmod +x run.sh
```

### 3️⃣ Run the manager

```bash
.main.sh
```

---

## 🎛️ Interface Flow

1. Choose an action:

   * Install
   * Uninstall
   * Exit

2. Choose the IDE(s):

   * IntelliJ Ultimate
   * PyCharm Pro
   * GoLand
   * RubyMine
   * PyCharm + IntelliJ
   * All

3. The selected scripts will run automatically.

---

## 📂 Project Structure

```text
src/
 ├── main.sh          # Main interactive manager
 └── apps/
     ├── intellij/
     │   ├── install.sh
     │   └── uninstall.sh
     ├── pycharm/
     │   ├── install.sh
     │   └── uninstall.sh
     ├── goland/
     │   ├── install.sh
     │   └── uninstall.sh
     └── ruby/
         ├── install.sh
         └── uninstall.sh
```

---

## 🗑️ Uninstalling

Just run:

```bash
./src/main.sh
```

→ Choose **Uninstall**
→ Select the IDE(s) you want to remove.

The script removes:

* `/opt/<ide>`
* `/usr/local/bin/<command>`
* `.desktop` menu entries
* Icons from the system

---

## 🧑‍💻 Contributing

Feel free to open issues or pull requests with improvements, new IDEs, or UI enhancements.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE.txt).

---

If you want, next I can:
✔ Add version selection per IDE
✔ Add logging (`logs/manager.log`)
✔ Add auto-update support 😎
