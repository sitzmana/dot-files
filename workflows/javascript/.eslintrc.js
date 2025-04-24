module.exports = {
    root: true,
    env: {
      browser: true,
      es2021: true,
      node: true,
    },
    extends: [
      'eslint:recommended',
      'plugin:@typescript-eslint/recommended',
      'prettier',
    ],
    parser: '@typescript-eslint/parser',
    parserOptions: {
      ecmaVersion: 12,
      sourceType: 'module',
    },
    plugins: ['@typescript-eslint', 'import'],
    rules: {
      'no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
      'import/order': ['error', { 'newlines-between': 'always' }],
    },
  };