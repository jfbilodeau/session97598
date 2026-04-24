targetScope = 'resourceGroup'

@description('Azure region for the App Service resources.')
param location string = 'canadaeast'

@description('Name of the App Service Plan.')
param appServicePlanName string = 'session97598-asp'

@description('Name of the App Service Web App.')
param webAppName string = 'session97598'

@description('SKU name for the App Service Plan.')
param appServicePlanSku string = 'S1'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: appServicePlanName
  location: location
  kind: 'linux'
  sku: {
    name: appServicePlanSku
    tier: 'Standard'
    size: appServicePlanSku
    capacity: 1
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2024-11-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|10.0'
      minTlsVersion: '1.2'
    }
  }
}

output appServicePlanId string = appServicePlan.id
output webAppId string = webApp.id
output webAppDefaultHostName string = webApp.properties.defaultHostName
