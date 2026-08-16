# The Atomic Study of Terraform Variables

To understand Terraform variables at an "atomic level," we must break them down into two halves: **how they are constructed inside the code (their nucleus)** and **how values are injected into them from the outside (their electron cloud/assignment methods)**.

---

## Part 1: The 6 Ways to Inject Values (Precedence Order)

When Terraform runs, it searches multiple sources to find the values for your variables. If the same variable is defined in multiple places, Terraform resolves the conflict using a strict **order of precedence** (from lowest force to highest force).

Here are the 6 ways to assign values, ordered from **lowest precedence (1)** to **highest precedence (6)**:

```
[LOWEST PRECEDENCE]
  (1) Environment Variables (TF_VAR_x)
   │
  (2) Default Values inside variable block
   │
  (3) terraform.tfvars file
   │
  (4) terraform.tfvars.json file
   │
  (5) *.auto.tfvars & *.auto.tfvars.json files (alphabetical order)
   │
  (6) CLI Flags (-var and -var-file)
[HIGHEST PRECEDENCE - OVERRIDES ALL]
```

---

### 1. Environment Variables (Precedence: 1 - Weakest)
Terraform checks your operating system's environment variables. It looks specifically for variables prefixed with `TF_VAR_`.
* **PowerShell Syntax:**
  ```powershell
  $env:TF_VAR_rg_name = "my-env-rg"
  ```
* **Use Case:** Great for pipeline automation (like Jenkins or GitHub Actions) where credentials or environment names are stored in the runner environment.

### 2. Default Values (Precedence: 2)
The value hardcoded directly inside the variable declaration block.
* **Syntax:**
  ```hcl
  variable "rg_name" {
    type    = string
    default = "my-default-rg"
  }
  ```
* **Use Case:** Provides a fallback fallback value so the configuration works out of the box without requiring manual input.

### 3. The `terraform.tfvars` File (Precedence: 3)
A plain-text HCL file containing simple key-value assignments. Terraform automatically loads this file if it is named exactly `terraform.tfvars`.
* **Syntax:**
  ```hcl
  rg_name = "my-tfvars-rg"
  ```
* **Use Case:** Typically used to define environment-specific variables for local development.

### 4. The `terraform.tfvars.json` File (Precedence: 4)
Same behavior as `terraform.tfvars`, but written in JSON format. Terraform automatically loads it if named exactly `terraform.tfvars.json`.
* **Syntax:**
  ```json
  {
    "rg_name": "my-json-tfvars-rg"
  }
  ```
* **Use Case:** Useful when variables are generated dynamically by an external script or program.

### 5. Auto-loaded Files (`*.auto.tfvars` or `*.auto.tfvars.json`) (Precedence: 5)
Any file ending in `.auto.tfvars` or `.auto.tfvars.json` is automatically loaded by Terraform. If there are multiple files (e.g., `a.auto.tfvars` and `b.auto.tfvars`), they are processed in **alphabetical order**, meaning values in later files overwrite earlier ones.
* **Use Case:** Helps split variable values by component (e.g., `network.auto.tfvars`, `database.auto.tfvars`).

### 6. Command Line Flags (`-var` and `-var-file`) (Precedence: 6 - Strongest)
Passed directly into the terminal at execution time. This overrides every other assignment method.
* **Inline Flag Syntax:**
  ```bash
  terraform plan -var="rg_name=my-cli-rg"
  ```
* **Custom File Flag Syntax:**
  ```bash
  terraform plan -var-file="production.tfvars"
  ```
* **Use Case:** Used by CI/CD scripts or operators to force specific configuration variables on the fly.

---

## Part 2: The Fallback Prompt (Interactive Mode)

What happens if a variable is declared **without a default**, and **none** of the 6 assignment methods above are used?

Terraform will halt execution, enter **Interactive Prompt Mode**, and request input directly from the user:
```
var.rg_name
  Enter a value:
```
*Note: In automated environments (CI/CD), this prompt will cause the pipeline to freeze or crash, which is why automation scripts use `-input=false` to disable prompts.*

---

## Part 3: The Nucleus — Anatomy of a Variable Block

Let's dissect the declaration of a single variable block. Each parameter inside the block configures a different aspect of its behavior:

```hcl
variable "instance_count" {
  type        = number                  # 1. Type Constraint
  description = "Number of instances"   # 2. Documentation
  default     = 3                       # 3. Default Fallback
  sensitive   = false                   # 4. Output Obfuscation
  nullable    = false                   # 5. Null Protection

  validation {                          # 6. Custom Input Validation
    condition     = var.instance_count > 0 && var.instance_count <= 10
    error_message = "The instance count must be between 1 and 10."
  }
}
```

### 1. `type` (Type Constraints)
Defines what data structure the variable accepts.
* **Primitive Types:** `string`, `number`, `bool`.
* **Complex Types (Collections):**
  - `list(...)` - Ordered sequence of values indexed by numbers.
  - `set(...)` - Unordered collection of unique values.
  - `map(...)` - Key-value lookup table.
* **Structural Types:**
  - `object({ ... })` - A schema-defined object (like a struct).
  - `tuple([...])` - A list containing different types of values.

### 2. `description`
Provides inline documentation. When using UI-based platforms (like Terraform Cloud) or auto-generating documentation, this string is used to explain the variable's purpose.

### 3. `default`
Defines the fallback value, as described in Part 1.

### 4. `sensitive`
If set to `true`, Terraform will mask the variable's value in terminal outputs (`plan` and `apply`) as `(sensitive value)` to prevent exposing passwords, tokens, or private keys.
* *Warning: The value is still saved in plain text in the `terraform.tfstate` database file.*

### 5. `nullable`
Specifies if the variable can be set to `null`. If `nullable = false` (default) and someone passes `null`, Terraform will automatically fall back to the variable's default value instead.

### 6. `validation` Block
Allows you to write custom rules.
- **`condition`**: A boolean expression that must evaluate to `true`.
- **`error_message`**: The error message printed to the screen if the condition evaluates to `false`.
