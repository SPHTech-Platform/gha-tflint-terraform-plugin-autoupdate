# gha-tflint-terraform-plugin-autoupdate

This action runs pre-commit autoupdate command to update the versions in the pre-commit yaml file and makes a PR to the repo for updates

# Example usage

Insert into part of the steps workflow

```yaml
steps:
  - uses: SPHTech-Platform/gha-tflint-terraform-plugin-autoupdate
    name: Update pre-commit config automatically
    with:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
