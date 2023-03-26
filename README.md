# infra

Inspired by https://github.com/ifd3f/infra

## Question posed to ChatGPT-4: How can I use a single GitHub repository to store non-sensitive information about my device configurations and scripts, without storing any passwords or keys? Please provide the markdown code containing my question and your answer.

**Answer**: Follow these steps to use a single GitHub repository for storing non-sensitive information while ensuring no passwords or keys are accidentally shared:

1. **Create a new public repository**: Go to your GitHub account, create a new repository, and set its visibility to "Public." Give it a relevant name and add a README file to provide an overview of the repository contents.
2. **Organize your files**: Structure your repository with directories for different device configurations, scripts, and other relevant files. This will make it easy for others to navigate and understand the purpose of each file.
3. **Use .gitignore**: Create a `.gitignore` file in the root directory of your repository. This file is used to specify files or directories that should not be tracked by Git, which can help prevent accidentally committing sensitive information. For example, if you have a directory called "secrets," you can add `/secrets/` to your .gitignore file.
4. **Environment variables**: Instead of hardcoding sensitive information (e.g., passwords, API keys) directly into your scripts or configuration files, use environment variables. This will allow you to keep sensitive information separate from your code and prevent it from being shared in the repository.
5. **Document how to set up environment variables**: In your README file or a separate documentation file, provide instructions for setting up the required environment variables. This will help others set up the necessary variables in their local environment without exposing sensitive information.
6. **Perform regular audits**: Regularly review your repository for any accidentally committed sensitive information. You can use tools like `git-secrets` or `truffleHog` to scan your repository history for secrets.
7. **Commit carefully**: Always review your changes before committing them to ensure that no sensitive information is accidentally included. Use `git diff` to see the changes you are about to commit.
8. **Educate collaborators**: If you have collaborators on the repository, ensure they are aware of the importance of not committing sensitive information and provide them with guidelines on how to use environment variables and .gitignore files.
