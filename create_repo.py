import json
import urllib.request
import os
import subprocess

def create_github_repo():
    print("--- GitHub Repository Creator ---")
    
    # 1. Get User Input
    username = input("Enter your GitHub username: ").strip()
    token = input("Enter your GitHub Personal Access Token (PAT): ").strip()
    repo_name = "SafeHer"
    description = "Safety education app for iOS built with SwiftUI."
    
    # 2. Prepare API Request
    url = "https://api.github.com/user/repos"
    data = json.dumps({
        "name": repo_name,
        "description": description,
        "private": False,
        "has_issues": True,
        "has_projects": True,
        "has_wiki": True
    }).encode("utf-8")
    
    headers = {
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github.v3+json",
        "Content-Type": "application/json"
    }
    
    # 3. Call GitHub API
    req = urllib.request.Request(url, data=data, headers=headers, method="POST")
    
    try:
        with urllib.request.urlopen(req) as response:
            res_data = json.loads(response.read().decode())
            html_url = res_data['html_url']
            print(f"\n✅ Success! Repository created at: {html_url}")
            
            # 4. Link Local Repo
            print("\nLinking local repository...")
            repo_url = f"https://github.com/{username}/{repo_name}.git"
            
            # Add remote
            subprocess.run(["git", "remote", "add", "origin", repo_url], check=False)
            
            # Push
            print(f"Pushing to {repo_url}...")
            subprocess.run(["git", "branch", "-M", "main"], check=True)
            subprocess.run(["git", "push", "-u", "origin", "main"], check=True)
            
            print("\n🚀 All done! Your project is now on GitHub.")

    except urllib.error.HTTPError as e:
        print(f"\n❌ Error: {e.code} - {e.read().decode()}")
    except Exception as e:
        print(f"\n❌ An error occurred: {e}")

if __name__ == "__main__":
    create_github_repo()
