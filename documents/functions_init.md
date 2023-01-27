# Cloud Functions の初め方

```shell
% npm --version
9.4.0
% firebase --version
11.21.0
```

事前に ``npm install -g firebase-tools`` コマンドよりインストールをしておく必要があります。

- ``cd firebase`` で ``firebase`` ディレクトリに移動する。
- ``firebase init functions`` で Cloud Functions の初期化を行う。
- ``,vscode/settings.json`` に以下を追記する。

```json
{
    "eslint.workingDirectories": ["./firebase/functions"]
}
```

- 必要なパッケージをインストールする。
    - prettier のインストール ``npm i -D prettier``
    - eslint-config-prettier のインストール ``npm i -D eslint-config-prettier``
- ``.prettierrc`` ファイルを作成し prettier の設定を行う。
- ``.eslintrc.js`` ファイルを以下のように変更する。

```js
module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    `eslint:recommended`,
    `plugin:import/errors`,
    `plugin:import/warnings`,
    `plugin:import/typescript`,
    `google`,
    `plugin:@typescript-eslint/recommended`,
    `prettier`,
  ],
  parser: `@typescript-eslint/parser`,
  parserOptions: {
    project: [`tsconfig.json`, `tsconfig.dev.json`],
    sourceType: `module`,
  },
  ignorePatterns: [
    `/lib/**/*`, // Ignore built files.
  ],
  plugins: [
    `@typescript-eslint`,
    `import`,
  ],
  rules: {
    "quotes": [`error`, `backtick`],
    "import/no-unresolved": 0,
  },
};
```
