//final  baseUrl ="http://localhost:8080/";
const baseServ = "https://ptc.yorkacademy.uk/";
const baseUrl = "${baseServ}api/";
   const storageUrl = "${baseServ}storage/";
const user = "user/";
const mailBox = "mailBox/";
const request = "request";
const replay = "replay";
const users = "users";

class AppUrl {

  /// User
  ///*******************************************************************************
  ///<------------------------------------------------------------------------------
  // static final getUser = "${baseUrl}";
  static const login = "${baseUrl}login";
  static const register = "${baseUrl}register";
  static const logout = "${baseUrl}logout";
  static const getProfile = '${baseServ}api';

  ///------------------------------------------------------------------------------>


  ///Mail Box
  ///*******************************************************************************
  ///<------------------------------------------------------------------------------

  ///Request
  static const requestMailBox = "$baseUrl$mailBox$request";
  static const requestMailBoxById = "$baseUrl$mailBox$request/";
  static const getInfoMailBox = "$baseUrl$mailBox$request/getInfoMailBox";
  static const createRequestBox = "$baseUrl$mailBox$request/storeRequest";
  static const uploadFileRequestBox= "$baseUrl$mailBox$request/uploadFile";
  static const requestBoxTypeGlobal= "${baseUrl}request_type";

  ///Replay
  static const replayMailbox = "$baseUrl$mailBox$replay";
  static const replayMailboxById = "$baseUrl$mailBox$replay/";
  static const createReplayBoxBox = "$baseUrl$mailBox$replay/storeReplay";
  static const uploadFileReplayBox= "$baseUrl$mailBox$replay/uploadFile";
///------------------------------------------------------------------------------>


  ///Users
  ///*******************************************************************************
  ///<------------------------------------------------------------------------------
  static const searchUsersByTerm = "$baseUrl$users";
///------------------------------------------------------------------------------>
  ///
  ///*******************************************************************************
  ///<------------------------------------------------------------------------------
  ///------------------------------------------------------------------------------>

  ///*******************************************************************************
  ///<------------------------------------------------------------------------------
  ///------------------------------------------------------------------------------>

  ///*******************************************************************************
  ///<------------------------------------------------------------------------------
  ///------------------------------------------------------------------------------>

  ///*******************************************************************************
  ///<------------------------------------------------------------------------------
  ///------------------------------------------------------------------------------>

}
