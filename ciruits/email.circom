
include "@zk-email/circuits/email-verifier.circom";
include "/regex.circom";

template EmailVerifier(max_header_bytes, max_body_bytes, n, k, pack_size) {}
 
    signal input in_padded[max_header_bytes];
    signal input pubkey[k];
    signal input signature[k];
    signal input in_len_padded_bytes;
    signal input address;
    signal input body_hash_idx;
    signal input precomputed_sha[32];
    signal input in_body_padded[max_body_bytes];
    signal input in_body_len_padded_bytes;
    signal input Email_username_idx;
    
    signal output pubkey_hash;
    signal output reveal_Email_packed[max_Email_packed_bytes];


    component EV = EmailVerifier(max_header_bytes, max_body_bytes, n, k, 0);
        EV.in_padded <== in_padded;
        EV.pubkey <== pubkey;
        EV.signature <== signature;
        EV.in_len_padded_bytes <== in_len_padded_bytes;
        EV.body_hash_idx <== body_hash_idx;
        EV.precomputed_sha <== precomputed_sha;
        EV.in_body_padded <== in_body_padded;
        EV.in_body_len_padded_bytes <== in_body_len_padded_bytes;
        pubkey_hash <== EV.pubkey_hash;