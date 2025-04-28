import { baseApiSlice } from "./baseApiSlice"
import type { Country, CountriesResponse, CreateCountryRequest } from "./types"

export const countryApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getCountries: builder.query<Country[], void>({
      query: () => "/country",
      transformResponse: (response: CountriesResponse) => response.countries || [],
      providesTags: ["Country"],
    }),

    getCountryById: builder.query<Country, number>({
      query: (id) => `/country/${id}`,
      transformResponse: (response: { country: Country }) => response.country,
      providesTags: (result, error, id) => [{ type: "Country", id }],
    }),

    createCountry: builder.mutation<Country, CreateCountryRequest>({
      query: (data) => ({
        url: "/country",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: { country: Country }) => response.country,
      invalidatesTags: ["Country"],
    }),

    updateCountry: builder.mutation<Country, { id: number; data: Partial<CreateCountryRequest> }>({
      query: ({ id, data }) => ({
        url: `/country/${id}`,
        method: "PUT",
        body: data,
      }),
      transformResponse: (response: { country: Country }) => response.country,
      invalidatesTags: (result, error, { id }) => [{ type: "Country", id }],
    }),

    deleteCountry: builder.mutation<void, number>({
      query: (id) => ({
        url: `/country/${id}`,
        method: "DELETE",
      }),
      invalidatesTags: ["Country"],
    }),
  }),
})

export const {
  useGetCountriesQuery,
  useGetCountryByIdQuery,
  useCreateCountryMutation,
  useUpdateCountryMutation,
  useDeleteCountryMutation,
} = countryApiSlice
