# Configuration Guide

## GitHub Repository Configuration

The Research Kit CLI dynamically reads GitHub repository information from `pyproject.toml`. This ensures consistency and makes the project forkable without code changes.

### ⚠️ IMPORTANT: Single Source of Truth

**ALL GitHub repository references MUST come from `pyproject.toml`.**

Never hardcode repository URLs in Python code!

### Configuration Location

Edit `pyproject.toml`:

```toml
[project.urls]
Homepage = "https://github.com/YOUR_USERNAME/research-kit"
Repository = "https://github.com/YOUR_USERNAME/research-kit"
Issues = "https://github.com/YOUR_USERNAME/research-kit/issues"
Documentation = "https://github.com/YOUR_USERNAME/research-kit/blob/main/README.md"

[tool.research-kit]
github_owner = "YOUR_USERNAME"
github_repo = "research-kit"
```

### How It Works

The CLI uses `_get_github_config()` function which:

1. **Primary source**: Reads from `[tool.research-kit]` section
2. **Fallback**: Parses from `[project.urls.Repository]`
3. **Default**: Returns `nguyenvanduocit/research-kit` if all fail

### For Forks

If you fork this repository:

1. Update `pyproject.toml` with your GitHub username
2. No code changes needed!
3. CLI will automatically use your repository

Example for user `johndoe`:

```toml
[tool.research-kit]
github_owner = "johndoe"
github_repo = "research-kit"
```

### Documentation URLs

When updating repository owner, also update these files:

```bash
# Use sed to update all documentation URLs at once:
find docs/ -name "*.md" -exec sed -i '' 's/OLD_USERNAME/NEW_USERNAME/g' {} \;
sed -i '' 's/OLD_USERNAME/NEW_USERNAME/g' README.md CONTRIBUTING.md AGENTS.md SUPPORT.md CHANGELOG.md
```

### Verification

After changes, verify the configuration is read correctly:

```python
from research_cli import _get_github_config
owner, repo = _get_github_config()
print(f"Owner: {owner}, Repo: {repo}")
```

Or test the CLI:

```bash
research init test-project --ai claude
# Should fetch from YOUR_USERNAME/research-kit
```

### Common Mistakes to Avoid

❌ **DON'T**: Hardcode repository URLs in Python code
```python
repo_owner = "someone"  # BAD!
```

✅ **DO**: Use the configuration function
```python
repo_owner, repo_name = _get_github_config()  # GOOD!
```

❌ **DON'T**: Update URLs in only one place

✅ **DO**: Update `pyproject.toml` first, then regenerate docs if needed

### CI/CD Integration

The GitHub Actions workflow automatically:
- Reads repository info from `pyproject.toml`
- Creates release packages with correct URLs
- Publishes to the configured repository

No workflow changes needed when forking!
