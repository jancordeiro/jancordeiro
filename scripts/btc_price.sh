#!/bin/bash
#
# Bitcoin Price CLI - Version 1.0
# Author: Penguin Dev
# Author URI: https://jancordeiro.github.io
#

# Endpoint da API CoinGecko
API_URL="https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&market_data=true"

# Requisição à API
RESPONSE=$(curl -s "$API_URL")

# Verifica se houve erro
if [ -z "$RESPONSE" ]; then
    echo "Erro ao acessar a API da CoinGecko."
    exit 1
fi

# Preços
PRICE_USD=$(echo "$RESPONSE" | jq '.market_data.current_price.usd')
PRICE_EUR=$(echo "$RESPONSE" | jq '.market_data.current_price.eur')
PRICE_BRL=$(echo "$RESPONSE" | jq '.market_data.current_price.brl')

# Marketcap
MARKETCAP_USD=$(echo "$RESPONSE" | jq '.market_data.market_cap.usd')

# Variações em porcentagem
VAR_24H=$(echo "$RESPONSE" | jq '.market_data.price_change_percentage_24h')
VAR_7D=$(echo "$RESPONSE" | jq '.market_data.price_change_percentage_7d')
VAR_30D=$(echo "$RESPONSE" | jq '.market_data.price_change_percentage_30d')

# Exibição
echo "=== Bitcoin (BTC) ==="
echo "💰 Preço:"
echo "   USD: \$${PRICE_USD}"
echo "   EUR: €${PRICE_EUR}"
echo "   BRL: R\$${PRICE_BRL}"

echo ""
echo "📊 Marketcap: \$${MARKETCAP_USD}"
echo ""
echo "📈 Variações:"
echo "   📆 24h: ${VAR_24H}%"
echo "   📅 7 dias: ${VAR_7D}%"
echo "   📅 30 dias: ${VAR_30D}%"
