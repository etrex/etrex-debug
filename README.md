# HTTP Request Debug Tool

HTTP Request Debug Tool 是一個用來擷取和檢視 HTTP 請求的工具。它可以紀錄所有進入的 HTTP 請求，包含請求方法、參數、標頭、請求本體和來源 IP 位址等資訊。這個工具特別適合用於開發和除錯 Webhook、API 或其他需要檢查 HTTP 請求的情境。

## 功能特點

- 擷取所有 HTTP 請求（GET、POST、PUT、DELETE 等）
- 紀錄請求的詳細資訊：
  - URL 和來源網址
  - HTTP 方法
  - 請求參數
  - 請求標頭
  - 請求本體
  - 來源 IP 位址
- 自動保留最新的 100 筆請求紀錄
- 支援 Facebook Webhook 驗證
- 提供清除所有紀錄的功能
- 提供 JSON 格式的回應

## 系統需求

- Ruby 3.3.5
- PostgreSQL
- Rails 8.0.2

## 最新更新

### 2025-04-28
- 升級 Ruby 版本至 3.3.5
- 升級 Rails 版本至 8.0.2
- 移除不必要的相依套件（Turbo、Stimulus、Importmap）
- 簡化資產管理設定
- 轉移部署平台從 Fly.io 至 Heroku

## 本機開發設定

1. 複製專案：
```bash
git clone https://github.com/etrex/etrex-debug.git
cd etrex-debug
```

2. 安裝相依套件：
```bash
bundle install
```

3. 設定資料庫：
```bash
rails db:create
rails db:migrate
```

4. 啟動伺服器：
```bash
rails server
```

現在你可以開啟 http://localhost:3000 來使用這個工具。

## 部署至 Heroku

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

點擊上方按鈕即可一鍵部署至 Heroku。系統會自動：
- 設定 RAILS_ENV 為 production
- 從專案中讀取並設定 RAILS_MASTER_KEY
- 建立並設定 PostgreSQL 資料庫
- 執行資料庫遷移

### 手動部署步驟

1. 安裝 Heroku CLI：
```bash
brew install heroku
```

2. 登入 Heroku：
```bash
heroku login
```

3. 建立 Heroku 應用：
```bash
heroku create your-app-name
```

4. 新增 PostgreSQL 資料庫：
```bash
heroku addons:create heroku-postgresql:essential-0
```

注意：essential-0 方案有下列限制：
- 不支援資料庫複製和主從架構
- 不支援查詢效能監控
- 每月預期可用性為 99.5%
- 無預告的維護和自動版本升級
- 不提供 PostgreSQL 日誌
- 不支援額外的證證

5. 部署應用：
```bash
git push heroku main
```

6. 執行資料庫遷移：
```bash
heroku run rails db:migrate
```

## 使用方式

1. 開啟首頁可以看到最近 100 筆請求的列表
2. 點擊單筆請求可以查看其詳細資訊
3. 開啟 `/delete` 可以清除所有紀錄
4. 任何發送到此服務的 HTTP 請求都會被紀錄下來

## Facebook Webhook 支援

本工具支援 Facebook Webhook 的驗證機制。當收到包含 `hub.challenge` 參數的請求時，會自動回傳該參數值，完成 Webhook 驗證。

## 技術規格

- 使用 Ruby 3.3.5 和 Rails 8.0.2
- 使用 PostgreSQL 作為資料庫
- 使用 Puma 6.4 作為應用伺服器
- 使用 SCSS 進行樣式管理
- 最小化前端相依套件，無需 JavaScript 框架
- 使用 Heroku 進行部署

## 注意事項

- 系統只保留最新的 100 筆請求紀錄
- 所有超過 100 筆的舊紀錄會被自動刪除
- 請勿在正式環境中存儲敏感資訊
- 確保設定適當的環境變數（如有需要）

## 貢獻

歡迎提交 Pull Requests 來改善這個工具。在提交之前，請確保：

1. 程式碼符合專案的編寫風格
2. 新增適當的測試
3. 更新相關文件

## 授權

本專案採用 MIT 授權條款。
