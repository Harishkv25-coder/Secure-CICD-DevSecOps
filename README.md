# Secure DevSecOps CI/CD Pipeline

## Project Overview

This project demonstrates a secure and automated CI/CD pipeline using GitHub Actions, DevSecOps security tools, Terraform, AWS OIDC authentication, and GitHub Pages.

The objective is to integrate security checks into the CI/CD workflow and automate static website deployment.

## Project Architecture

**Developer → GitHub Repository → GitHub Actions → Security Scanning → GitHub Pages Deployment**

Terraform is used to define AWS infrastructure, with automated read-only planning through GitHub Actions.

## Technologies Used

- Git and GitHub
- GitHub Actions
- HTML5 and CSS3
- Gitleaks – Secret detection
- Checkov – Infrastructure security scanning
- Terraform – Infrastructure as Code
- AWS IAM – Identity and access management
- AWS OIDC – Secure authentication without storing permanent AWS access keys
- GitHub Pages – Static website hosting

## Project Features

### 1. Continuous Integration
- Automated HTML validation
- CSS file validation
- README validation

### 2. DevSecOps Security
- Automated secret scanning using Gitleaks
- Terraform security scanning using Checkov

### 3. Secure Cloud Authentication
- GitHub Actions authentication with AWS using OIDC
- IAM role-based authentication
- No permanent AWS access keys stored in GitHub

### 4. Infrastructure as Code
- AWS infrastructure defined using Terraform
- Automated Terraform initialization and planning
- Read-only Terraform plan workflow

### 5. Continuous Deployment
- Automated website deployment through GitHub Actions
- GitHub Pages hosting
- Deployment triggered by pushes to the main branch

## Application

A static website built using HTML and CSS to demonstrate automated CI/CD deployment and DevSecOps integration.

## Deployment

**Live Website:**  
https://harishkv25-coder.github.io/Secure-CICD-DevSecOps/

**GitHub Repository:**  
https://github.com/Harishkv25-coder/Secure-CICD-DevSecOps

## Security Implementation

- Secret scanning with Gitleaks
- Infrastructure security scanning with Checkov
- AWS authentication using GitHub OIDC
- IAM role-based access
- Terraform plan-only execution without provisioning AWS resources

## Current Project Status

- [x] Static website development
- [x] GitHub repository setup
- [x] GitHub Actions CI pipeline
- [x] Gitleaks integration
- [x] Checkov integration
- [x] AWS OIDC authentication
- [x] Terraform read-only planning
- [x] GitHub Pages configuration
- [x] Automated GitHub Pages deployment

**Website hosting:** GitHub Pages

**AWS infrastructure:** Defined using Terraform but not provisioned.

## Project Objective

To demonstrate practical DevSecOps skills by integrating continuous integration, security scanning, secure cloud authentication, Infrastructure as Code, and automated deployment into a single CI/CD workflow.
