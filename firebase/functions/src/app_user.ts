import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'

export const onCreateDeleteUser = functions
    .region(`asia-northeast1`)
    .firestore.document(`deleted_users/{docId}`)
    .onCreate(async (snapshot) => {
        const deleteDocument = snapshot.data()
        const uid = deleteDocument.uid

        // Authenticationのユーザーを削除する
        await admin.auth().deleteUser(uid)
    })
