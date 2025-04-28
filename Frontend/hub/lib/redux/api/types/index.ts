export interface BaseResponse<T> {
  message?: string
  data: T
  status: number
}

export interface ContestProblem {
  index: string
  name: string
  tags: string[]
}

export interface ContestMember {
  handle: string
  id?: number
}

export interface ContestParty {
  members: ContestMember[]
}

export interface ProblemResult {
  points: number
  rejectedAttemptCount: number
  type: string
  bestSubmissionTimeSeconds: number
}

export interface ContestRow {
  party: ContestParty
  rank: number
  points: number
  penalty: number
  problemResults: ProblemResult[]
}

export interface ContestDetail {
  contest: {
    id: number
    name: string
    type: string
  }
  problems: ContestProblem[]
  rows: ContestRow[]
}

export interface ContestResponse {
  status: string
  result: ContestDetail
}

export interface ContestsListResponse extends BaseResponse<ContestResponse[]> {}
export interface ContestDetailResponse extends BaseResponse<ContestResponse> {}

export interface User {
  id: number
  role_id: number
  name: string
  country_id: number
  university: string
  email: string
  AvatarURL: string
  preferred_language: string
  group_id: number
  birthday: string
  role: string
  country: string
}

export interface UsersResponse extends BaseResponse<User[]> {}
export interface UserResponse extends BaseResponse<User> {}

export interface Session {
  ID: number
  Name: string
  Description: string
  StartTime: string
  EndTime: string
  MeetLink: string
  Location: string
  ResourceLink: string
  RecordingLink: string
  CalendarEventID: string
  LecturerID: number
  FundID: number
  CreatedAt: string
  UpdatedAt: string
}

export interface SessionsResponse extends BaseResponse<Session[]> {}
export interface SessionResponse extends BaseResponse<Session> {}

export interface Submission {
  ID: number
  ProblemID: number
  UserID: number
  Language: string
  TimeSpent: number
  Tries: number
  InContest: boolean
  Code: string
  Verified: boolean
  CreatedAt: string
  UpdatedAt: string
}

export interface SubmissionsResponse extends BaseResponse<Submission[]> {}
export interface SubmissionResponse extends BaseResponse<Submission> {}

export interface CreateSubmissionRequest {
  problemID: number
  userID: number
  Language: string
  TimeSpent: number
  Tries: number
  InContest: boolean
  Code: string
  Verified: boolean
}

export interface Group {
  id: number
  name: string
  code: string
  members: number
  timeSpent: string
  avgRating: string
}

export interface GroupsResponse extends BaseResponse<Group[]> {}

export interface CreateGroupRequest {
  name: string
  code: string
  members: number
  timeSpent: string
  avgRating: string
}

export interface Country {
  id: number
  name: string
  members: number
  problemsSolved: string
  timeSpent: string
  avgRating: string
  flag: string
}

export interface CountriesResponse extends BaseResponse<Country[]> {}

export interface CreateCountryRequest {
  name: string
  members: number
  problemsSolved: string
  timeSpent: string
  avgRating: string
  flag: string
}

export interface SuperGroup {
  ID: number
  Name: string
  CreatedAt: string
  UpdatedAt: string
}

export interface SuperGroupsResponse extends BaseResponse<SuperGroup[]> {}

export interface CreateSuperGroupRequest {
  Name: string
}

export interface Track {
  ID: number
  Name: string
  CreatedAt: string
  UpdatedAt: string
  Active: boolean
  SuperGroupID: number
  SuperGroup: SuperGroup
}

export interface TracksResponse extends BaseResponse<Track[]> {}

export interface CreateTrackRequest {
  Name: string
  Active: boolean
  SuperGroupID: number
}

export interface Role {
  ID: number
  Name: string
  CreatedAt: string
  UpdatedAt: string
}

export interface RolesResponse extends BaseResponse<Role[]> {}

export interface CreateRoleRequest {
  Name: string
}

export interface Invite {
  id: number
  email: string
  token: string
  expires_at: string
}

export interface InviteRequest {
  email: string
}

export interface BatchInviteRequest {
  emails: string[]
}
