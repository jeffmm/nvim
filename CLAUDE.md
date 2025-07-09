# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a LazyVim-based Neovim configuration with extensive customization and Python integration. The configuration follows a modular structure:

- **Entry Point**: `init.lua` sets up the leader key and loads core modules
- **Core Modules**: Located in `lua/` directory
  - `options.lua` - Global Neovim settings and behavior
  - `keymaps.lua` - Basic key mappings
  - `autocmds.lua` - Auto commands
  - `lazy-plugins.lua` - Plugin manager setup
  - `tabline.lua` - Custom tabline implementation
- **Plugin Configuration**: Individual plugin configs in `lua/plugins/`
- **LSP Configuration**: Structured in `lua/plugins/lsp/` with server-specific configs
- **Snacks Framework**: Modern UI components in `lua/plugins/snacks/`

## Key Architectural Patterns

### Plugin Organization
- Each plugin has its own file in `lua/plugins/`
- LSP configurations are grouped in `lua/plugins/lsp/servers/`
- Snacks UI components are organized in `lua/plugins/snacks/`
- All plugins follow lazy loading patterns via LazyVim

### Python Integration
- Uses a dedicated Python virtual environment at `~/.config/nvim/.venv/`
- Python packages managed via `pyproject.toml` with uv
- Includes AI/ML tools: `crawl4ai`, `pydantic-ai`, `vectorcode`
- Python host configured in `options.lua:6`

### Configuration Structure
- Leader key is space (`<leader> = " "`)
- Uses 2-space indentation consistently
- Nerd Font icons enabled by default
- Global statusline with extensive customization

## Common Development Commands

### Plugin Management
```bash
# Launch Neovim plugin manager
nvim -c "Lazy"

# Update all plugins
nvim -c "Lazy update"

# Clean unused plugins
nvim -c "Lazy clean"
```

### Python Environment
```bash
# Install Python dependencies
cd ~/.config/nvim && uv sync

# Activate virtual environment
source ~/.config/nvim/.venv/bin/activate

# Install new Python package
uv add <package-name>
```

### Code Formatting
```bash
# Format Lua files with stylua
stylua .

# Format Python files (if present)
cd ~/.config/nvim && uv run ruff format .
```

### Testing
```bash
# Run Python tests
cd ~/.config/nvim && uv run pytest

# Check Neovim configuration health
nvim -c "checkhealth"
```

## Key Configuration Files

- `init.lua` - Main entry point, loads all modules
- `lua/options.lua` - Core Neovim settings (Python host, UI, editing behavior)
- `lua/plugins/lsp/init.lua` - LSP client configuration and diagnostics
- `lua/plugins/snacks/init.lua` - Modern UI framework configuration
- `stylua.toml` - Lua formatting rules (2 spaces, 120 column width)
- `pyproject.toml` - Python dependencies and project metadata

## Development Workflow

1. **Adding New Plugins**: Create new file in `lua/plugins/` following existing patterns
2. **LSP Configuration**: Add server configs in `lua/plugins/lsp/servers/`
3. **UI Components**: Extend Snacks components in `lua/plugins/snacks/`
4. **Python Tools**: Add dependencies to `pyproject.toml` and run `uv sync`
5. **Testing Changes**: Use `:checkhealth` and `:Lazy` to verify configuration

## Special Features

- **Code Companion**: AI-powered coding assistance with custom configuration
- **Vectorcode**: Vector-based code search and analysis
- **Chroma Integration**: Document analysis via `chroma_config.yaml`
- **Custom Tabline**: Custom implementation in `lua/tabline.lua`
- **Multi-format Support**: Configured for web development, Python, and more

## File Structure Patterns

- Plugin files return a table with lazy.nvim specification
- LSP servers have individual config files with setup functions
- Snacks components use modern async patterns
- All configs follow 2-space indentation with 120-character line width