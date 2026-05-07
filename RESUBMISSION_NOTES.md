# BodyReader 再提出メモ

## 今回の変更

- アプリ全体のデザインを刷新
- 生成AI画像をアプリ内に追加
- アプリアイコンを新デザインへ差し替え
- 図鑑、詳細、クイズ、シーン、ガイド画面を作り直し
- 文字化けしていた日本語データを修正
- App Store用スクリーンショットを更新

## 再提出前に必要なこと

今回の変更はスクリーンショットだけでなく、アプリ本体とアイコンも変わっています。
そのため、App Store Connectで再提出する前に、MacのXcodeで新しいビルドをアップロードしてください。

## Mac側の流れ

1. `C:\Users\Windows\BodyReader` のプロジェクトをMacへコピー
2. `BodyReader.xcodeproj` をXcodeで開く
3. Signing & CapabilitiesでTeamを設定
4. Versionは `1.0` のままでも可。Buildは既存より大きい番号へ変更
5. 実機またはシミュレータで表示確認
6. Product > Archive
7. Distribute App > App Store Connectへアップロード
8. App Store Connectで新しいビルドを選択
9. スクリーンショットを以下に差し替え

## スクリーンショット

- `ss_new_1.png`
- `ss_new_2.png`
- `ss_new_3.png`
- `ss_new_4.png`
- `ss_new_5.png`

提出用3枚版:

- `ss_clean/ss_1290x2796_1.png`
- `ss_clean/ss_1290x2796_2.png`
- `ss_clean/ss_1290x2796_3.png`

## App Review Notes 案

BodyReader is a body-language learning app.  
This update refreshes the visual design, app icon, screenshots, and in-app educational illustrations.  
The app does not diagnose emotions or make medical claims. It presents body-language cues as learning hints and encourages users not to judge others from a single sign.

No login is required.
