# HTTP Request Debug Tool

HTTP Request Debug Tool 是一個用於捕獲和檢視 HTTP 請求的工具。它可以記錄所有進入的 HTTP 請求，包括請求方法、參數、標頭、請求體和來源 IP 地址等信息。這個工具特別適合用於開發和調試 Webhook、API 或其他需要檢查 HTTP 請求的場景。

## 功能特點

- 捕獲所有 HTTP 請求（GET、POST、PUT、DELETE 等）
- 記錄請求的詳細信息：
  - URL 和來源網址
  - HTTP 方法
  - 請求參數
  - 請求標頭
  - 請求體
  - 來源 IP 地址
- 自動保留最新的 100 條請求記錄
- 支持 Facebook Webhook 驗證
- 提供清除所有記錄的功能
- 提供 JSON 格式的響應

## 系統需求

- Ruby 2.7.4
- PostgreSQL
- Rails 6.1.3+

## 本地開發設置

1. 克隆專案：
```bash
git clone https://github.com/etrex/etrex-debug.git
cd etrex-debug
```

2. 安裝依賴：
```bash
bundle install
```

3. 設置數據庫：
```bash
rails db:create
rails db:migrate
```

4. 啟動服務器：
```bash
rails server
```

現在你可以訪問 http://localhost:3000 來使用這個工具。

## 部署到 Fly.io

這個專案已配置為可以部署到 Fly.io。以下是部署步驟：

1. 安裝 Fly CLI：
```bash
brew install flyctl
```

2. 登入 Fly.io：
```bash
fly auth login
```

3. 部署應用：
```bash
fly deploy
```

部署配置已在 `fly.toml` 中定義，包括：
- 應用名稱：etrex-debug
- 使用 HTTPS
- 自動 SSL 證書
- 自動回滾功能
- 連接數限制（軟限制：20，硬限制：25）

## 使用方法

1. 訪問首頁可以看到最近 100 條請求的列表
2. 點擊單個請求可以查看其詳細信息
3. 訪問 `/delete` 可以清除所有記錄
4. 任何發送到此服務的 HTTP 請求都會被記錄下來

## Facebook Webhook 支持

本工具支持 Facebook Webhook 的驗證機制。當收到包含 `hub.challenge` 參數的請求時，會自動返回該參數值，完成 Webhook 驗證。

## 注意事項

- 系統只保留最新的 100 條請求記錄
- 所有超過 100 條的舊記錄會被自動刪除
- 請勿在生產環境中存儲敏感信息

## 貢獻

歡迎提交 Pull Requests 來改進這個工具。

## 授權

本專案採用 MIT 授權條款。
