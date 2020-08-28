const path = require('path');
const glob = require('glob');
const HardSourceWebpackPlugin = require('hard-source-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const {VueLoaderPlugin} = require('vue-loader');

module.exports = (env, options) => {
    const devMode = options.mode !== 'production';

    return {
        optimization: {
            minimizer: [
                new TerserPlugin({cache: true, parallel: true, sourceMap: devMode}),
                new OptimizeCSSAssetsPlugin({})
            ]
        },
        entry: {
            'app': glob.sync('./vendor/**/*.js').concat(['./js/app.js'])
        },
        output: {
            filename: 'app.js',
            path: path.resolve(__dirname, '../priv/static/js'),
            publicPath: '/js/'
        },
        devtool: devMode ? 'eval-cheap-module-source-map' : undefined,
        module: {
            rules: [
                {
                    test: /\.js$/,
                    exclude: /node_modules/,
                    use: {
                        loader: 'babel-loader'
                    }
                },
                {
                    test: /\.[s]?css$/,
                    use: [
                        MiniCssExtractPlugin.loader,
                        'css-loader',
                        'sass-loader',
                    ],
                },
                {
                    test: /\.vue$/,
                    exclude: /node_modules/,
                    loader: 'vue-loader',
                }
            ]
        },
        plugins: [
            new MiniCssExtractPlugin({filename: '../css/app.css'}),
            new CopyWebpackPlugin({
                patterns: [
                    { from: path.resolve('./modules/web/static/'), to: './assets' },
                    { from: path.resolve('./modules/web/static/favicon.ico'), to: './' },
                ]
            }),
            new VueLoaderPlugin()
        ]
            .concat(!devMode ? [] : [
                new HardSourceWebpackPlugin()]),
        resolve: {
            alias: {
                'vue$': 'vue/dist/vue.esm.js',
            },
        },

    }
};
