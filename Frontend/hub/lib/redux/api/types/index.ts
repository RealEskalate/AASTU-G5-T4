export interface BaseResponse<T> {
  message?: string
  data?: T
  status?: number
}

export interface Contest {
  ID: number
  Name: string
  Description?: string
  StartTime: string
  EndTime: string
  CreatedAt: string
  UpdatedAt: string
}

export interface ContestsResponse {
  contests: Contest[]
}

export interface Country {
  ID: number
  Name: string
  Code: string
  Flag: string
  CreatedAt: string
  UpdatedAt: string
}

export interface CountriesResponse {
  countries: Country[]
}

export interface CreateCountryRequest {
  Name: string
  Code: string
  Flag: string
}

export interface Group {
  ID: number
  Name: string
  Code: string
  CreatedAt: string
  UpdatedAt: string
}

export interface GroupsResponse {
  groups: Group[]
}

export interface CreateGroupRequest {
  Name: string
  Code: string
}

export interface Invite {
  ID: number
  Token: string
  Email: string
  RoleID: number
  CreatedAt: string
}

export interface InviteRequest {
  Email: string
  RoleID: number
}

export interface BatchInviteRequest {
  emails: string[]
  roleID: number
}

export interface Role {
  ID: number
  Name: string
  CreatedAt: string
  UpdatedAt: string
}

export interface RolesResponse {
  roles: Role[]
}

export interface CreateRoleRequest {
  Name: string
}

export interface Submission {
  ID: number
  ProblemID: number
  UserID: number
  Language: string
  TimeSpent: number
  Tries: number
  InContest: boolean
  CreatedAt: string
  UpdatedAt: string
}

export interface SubmissionsResponse {
  submissions: Submission[]
}

export interface CreateSubmissionRequest {
  ProblemID: number
  UserID: number
  Language: string
  TimeSpent: number
  Tries: number
  InContest: boolean
}

export interface SuperGroup {
  ID: number
  Name: string
  CreatedAt: string
  UpdatedAt: string
}

export interface SuperGroupsResponse {
  supergroups: SuperGroup[]
}

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

export interface TracksResponse {
  tracks: Track[]
}

export interface CreateTrackRequest {
  Name: string
  Active: boolean
  SuperGroupID: number
}

export interface User {
  ID: number
  FirstName: string
  LastName: string
  Email: string
  GroupID: number
  RoleID: number
  CreatedAt: string
  UpdatedAt: string
}

export interface UsersResponse {
  users: User[]
}

export interface CreateUserRequest {
  FirstName: string
  LastName: string
  Email: string
  GroupID: number
  RoleID: number
}
