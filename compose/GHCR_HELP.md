## Docker Authentication from GitHub Actions

To authenticate Docker with GitHub using a personal access token, follow these steps:

### 1. Generate a Token on GitHub
1. Go to `Settings` > `Developer settings` > `Personal access tokens`.
 
2. Click **Generate new token** and select the following permissions:
   - `read:packages`
  
3. Save the generated token in a secure location.
   
4. **Log from your terminal**:
  - Open a new terminal
  - Put the next command

   ```yaml
echo "your-token" | docker login ghcr.io -u your-user --password-stdin

   ```
5. **Run the next docker compose once logged**:

   ```yaml
   services:
      nbu-be:
        image: "ghcr.io/2025-p4-be/tpi-nbu:main"
        build: ./nbu
        ports:
          - "8015:8080"
        networks:
          nbu-network:
          back-end-network:
            priority: 1000
        environment:
          SPRING_PROFILES_ACTIVE: prod
          SPRING_DATASOURCE_URL: jdbc:mysql://nbu-db:3306/nbu
          SPRING_DATASOURCE_USERNAME: utn
          SPRING_DATASOURCE_PASSWORD: utn
   ```