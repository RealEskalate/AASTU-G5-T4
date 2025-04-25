// Common types
export interface BaseResponse<T> {
  message?: string
  data?: T
  status?: number
}

// SuperGroup types
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
  name: string
}

// Problem types
export interface Problem {
  ID: number
  ContestID: number | null
  TrackID: number | null
  Name: string
  Difficulty: string
  Tag: string
  Platform: string
  Link: string
  CreatedAt: string
  UpdatedAt: string
  Contest: any | null
  Track: any | null
}

export interface ProblemsResponse {
  problems: Problem[]
}

export interface CreateProblemRequest {
  name: string
  difficulty: string
  tag: string
  platform: string
  link: string
  contestID?: number
  trackID?: number
}

// Track types
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
  name: string
  superGroupID: number
}

// Country types
export interface Country {
  ID: number
  Name: string
  ShortCode: string
  CreatedAt: string
  UpdatedAt: string
}

export interface CountriesResponse {
  countries: Country[]
}

export interface CreateCountryRequest {
  Name: string
  ShortCode: string
}

// Group types
export interface Group {
  ID: number
  Name: string
  ShortName: string
  Description: string
  HOAID: number | null
  CountryID: number
  CreatedAt: string
  UpdatedAt: string
  Country: Country
}

export interface GroupsResponse {
  groups: Group[]
}

export interface CreateGroupRequest {
  Name: string
  ShortName: string
  Description: string
  HOAID?: number | null
  CountryID: number
}

// Role types
export interface Role {
  ID: number
  Type: string
  CreatedAt: string
  UpdatedAt: string
}

export interface RolesResponse {
  roles: Role[]
}

export interface CreateRoleRequest {
  type: string
}

// User types
export interface User {
  ID: number
  RoleID: number
  Name: string
  CountryID: number
  University: string
  Email: string
  Leetcode: string
  Codeforces: string
  Github: string
  Photo: string
  PreferredLanguage: string
  Hackerrank: string
  GroupID: number
  Phone: string
  TelegramUsername: string
  TelegramUID: string
  Linkedin: string
  StudentID: string
  ShortBio: string
  Instagram: string
  Birthday: string
  CV: string
  JoinedDate: string
  ExpectedGraduationDate: string
  MentorName: string
  TshirtColor: string
  TshirtSize: string
  Gender: string
  CodeOfConduct: string
  Password: string
  CreatedAt: string
  UpdatedAt: string
  Config: string
  Department: string
  Inactive: boolean
  Role?: Role
  Country?: Country
  Group?: Group
}

export interface UsersResponse {
  users: User[]
}

export interface CreateUserRequest {
  RoleID: number
  Name: string
  CountryID: number
  University: string
  Email: string
  Leetcode?: string
  Codeforces?: string
  Github?: string
  Photo?: string
  PreferredLanguage?: string
  Hackerrank?: string
  GroupID: number
  Phone?: string
  TelegramUsername?: string
  TelegramUID?: string
  Linkedin?: string
  StudentID?: string
  ShortBio?: string
  Instagram?: string
  Birthday?: string
  CV?: string
  JoinedDate?: string
  ExpectedGraduationDate?: string
  MentorName?: string
  TshirtColor?: string
  TshirtSize?: string
  Gender?: string
  CodeOfConduct?: string
  Password: string
  Department?: string
  Inactive?: boolean
}

// Submission types
export interface Submission {
  ID: number
  ProblemID: number
  UserID: number
  TimeSpent: number
  Tries: number
  InContest: number
  Code: string
  Language: string
  Verified: boolean
  CreatedAt: string
  UpdatedAt: string
  Problem?: Problem
  User?: User
}

export interface SubmissionsResponse {
  submissions: Submission[]
}

export interface CreateSubmissionRequest {
  problemID: number
  userID: number
  timeSpent: number
  tries: number
  inContest: number
  code: string
  language: string
  verified: boolean
}

// Contest types
export interface Contest {
  ID: number
  Name: string
  Link: string
  ProblemCount: number
  CreatedAt: string
  UpdatedAt: string
  Unrated: boolean
  SuperGroupID: number
  Type: string
  Link2: string
  Link3: string
  SuperGroup?: SuperGroup
}

export interface ContestsResponse {
  contests: Contest[]
}

// Invite types
export interface Invite {
  ID: number
  Key: string
  RoleID: number
  UserID: number
  GroupID: number
  Used: boolean
  CreatedAt: string
  UpdatedAt: string
}

export interface InviteRequest {
  email: string
  role_id: number
  group_id: number
  country_id: number
}

export interface BatchInviteRequest {
  emails: string[]
  role_id: number
  group_id: number
  country_id: number
}
