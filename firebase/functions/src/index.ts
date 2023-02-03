import * as admin from 'firebase-admin'
import * as serviceAccountKeyDev from '../../keys/service_account_key_dev.json'
import * as serviceAccountKeyProd from '../../keys/service_account_key_prod.json'

export const getIsProd = () => {
    console.log(`環境: `, process.env[`GCLOUD_PROJECT`])
    return process.env[`GCLOUD_PROJECT`] === `bad-log-2-prod`
}

// サービスアカウントを環境変数から取得
const serviceAccount = getIsProd()
    ? {
        type: serviceAccountKeyProd.type,
        projectId: serviceAccountKeyProd.project_id,
        privateKeyId: serviceAccountKeyProd.private_key_id,
        privateKey: serviceAccountKeyProd.private_key.replace(/\\n/g, `\n`),
        clientEmail: serviceAccountKeyProd.client_email,
        clientId: serviceAccountKeyProd.client_id,
        authUri: serviceAccountKeyProd.auth_uri,
        tokenUri: serviceAccountKeyProd.token_uri,
        authProviderX509CertUrl: serviceAccountKeyProd.auth_provider_x509_cert_url,
        clientC509CertUrl: serviceAccountKeyProd.client_x509_cert_url
    }
    : {
        type: serviceAccountKeyDev.type,
        projectId: serviceAccountKeyDev.project_id,
        privateKeyId: serviceAccountKeyDev.private_key_id,
        privateKey: serviceAccountKeyDev.private_key.replace(/\\n/g, `\n`),
        clientEmail: serviceAccountKeyDev.client_email,
        clientId: serviceAccountKeyDev.client_id,
        authUri: serviceAccountKeyDev.auth_uri,
        tokenUri: serviceAccountKeyDev.token_uri,
        authProviderX509CertUrl: serviceAccountKeyDev.auth_provider_x509_cert_url,
        clientC509CertUrl: serviceAccountKeyDev.client_x509_cert_url
    }

// Firebase Admin SDK の初期化
// https://firebase.google.com/docs/functions/config-env?hl=ja
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: `https://${serviceAccount.projectId}.firebaseio.com`
})

/**
 * ここでデプロイする関数をまとめる。
 * admin.initializeApp() の順序の問題でデプロイに失敗するため。
 *  */
import { onCreateDeleteUser } from '../src/app_user'

/** index.ts で import してデプロイする関数一覧  */
export { onCreateDeleteUser }
