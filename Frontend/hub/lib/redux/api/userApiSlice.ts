import { baseApiSlice } from "./baseApiSlice"
import type { User, UsersResponse, CreateUserRequest } from "./types"

export const userApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getUsers: builder.query<User[], void>({
      query: () => "/user",
      transformResponse: (response: UsersResponse) => response.users || [],
      providesTags: ["User"],
    }),

    getUserById: builder.query<User, number>({
      query: (id) => `/user/${id}`,
      transformResponse: (response: { user: User }) => response.user,
      providesTags: (result, error, id) => [{ type: "User", id }],
    }),

    getUsersByGroup: builder.query<User[], number>({
      query: (groupId) => `/user/users/group/${groupId}`,
      transformResponse: (response: UsersResponse) => response.users || [],
      providesTags: ["User"],
    }),

    createUser: builder.mutation<User, CreateUserRequest>({
      query: (data) => ({
        url: "/user",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: { user: User }) => response.user,
      invalidatesTags: ["User"],
    }),

    updateUser: builder.mutation<User, { id: number; data: Partial<CreateUserRequest> }>({
      query: ({ id, data }) => ({
        url: `/user/${id}`,
        method: "PUT",
        body: data,
      }),
      transformResponse: (response: { user: User }) => response.user,
      invalidatesTags: (result, error, { id }) => [{ type: "User", id }],
    }),

    deleteUser: builder.mutation<void, number>({
      query: (id) => ({
        url: `/user/${id}`,
        method: "DELETE",
      }),
      invalidatesTags: ["User"],
    }),

    createBulkUsers: builder.mutation<User[], any[]>({
      query: (data) => ({
        url: "/user/bulk",
        method: "POST",
        body: data,
      }),
      invalidatesTags: ["User"],
    }),

    uploadAvatar: builder.mutation<{ image_url: string; message: string }, { userId: number; formData: FormData }>({
      query: ({ userId, formData }) => ({
        url: `/user/users/${userId}/avatar`,
        method: "POST",
        body: formData,
      }),
      invalidatesTags: (result, error, { userId }) => [{ type: "User", id: userId }],
    }),
  }),
})

export const {
  useGetUsersQuery,
  useGetUserByIdQuery,
  useGetUsersByGroupQuery,
  useCreateUserMutation,
  useUpdateUserMutation,
  useDeleteUserMutation,
  useCreateBulkUsersMutation,
  useUploadAvatarMutation,
} = userApiSlice
