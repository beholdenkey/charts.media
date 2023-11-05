# Contribution Guide

We appreciate your interest in contributing to our project! Your feedback and contributions, whether it's a bug report, new feature, correction, or additional documentation, are highly valued.

Before you start, please familiarize yourself with this document to understand the contribution guidelines.

## Communication

We encourage you to discuss your plans and the changes you wish to make via GitHub issues before you start working. This ensures that your efforts align with the project's direction and allows you to receive feedback from the maintainers and the community.

## Conventional Commits Guide

Conventional Commits is a specification that adds human and machine-readable meaning to commit messages. It uses a structured format to facilitate version management and release notes. Here's a guide on how to follow it:

## Commit Message Structure

Each commit message consists of a header, a body, and a footer. The header is mandatory and must conform to the Commit Message Header format.

### Header

The header is crucial as it can be added directly to the changelog. It consists of a type, an optional scope, and a description.

### Type

The type must be one of the following:

- feat: A new feature
- fix: A bug fix
- docs: Documentation only changes
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- refactor: A code change that neither fixes a bug nor adds a feature
- perf: A code change that improves performance
- test: Adding missing tests or correcting existing tests
- chore: Changes to the build process or auxiliary tools and libraries such as documentation generation

### Scope

The scope is optional and can be anything specifying the place of the commit change.

### Description

The description is a brief explanation of the change. It should be written in the imperative, present tense: "change" not "changed" nor "changes". The first letter should not be capitalized, and there should be no period (.) at the end.

### Body

The body is optional and used to explain the what and why of a commit, not the how.

### Footer

The footer is optional and is used to reference issue tracker IDs.

### Example

Here's an example of a conventional commit:

```git
feat(user-auth): add login functionality

This commit adds login functionality to the user authentication system. It includes routes, controllers, and views for the login page.

Resolves #123
```

In our project, we have a rule that the header must not exceed 72 characters. This is defined in our .commitlintrc.yaml file.

## Pull Request Process

- Fork the repository and create your branch from main.

## Pull Request Title

Pull request titles must follow the following format:

- type: Must be one of the following: fix, feat, docs, ci, chore.
- scope: The scope of the changes. Must be one of the following: code, docs, ci. release is not allowed.
- subject: A brief description of the changes. Must start with an uppercase character.

Example:

```git
feat(code): Add new feature X
```

This format is known as Conventional Commits, and it leads to more readable messages that are easy to follow when looking through the project history.
