/* Copyright (C) Howard Thomson 2006 */
/* License: Eiffel Forum Freeware License V2 */

char *	c_at_offset (char *p, int offset) { return  ((char   *) (&p[offset])); }

char	c_get_char	(char *p, int offset) { return *((char   *) (&p[offset])); }
int		c_get_byte	(char *p, int offset) { return *((unsigned char   *) (&p[offset])); }
int		c_get_short	(char *p, int offset) { return *((unsigned short  *) (&p[offset])); }
int		c_get_long	(char *p, int offset) { return *((long   *) (&p[offset])); }
double	c_get_quad	(char *p, int offset) { return *((double *) (&p[offset])); }
float	c_get_float	(char *p, int offset) { return *((float  *) (&p[offset])); }
double	c_get_double(char *p, int offset) { return *((double *) (&p[offset])); }

void	c_put_char	(char *p, int offset, char   value) { *((char   *) (&p[offset])) = value; }
void	c_put_byte	(char *p, int offset, char   value) { *((char   *) (&p[offset])) = value; }
void	c_put_short	(char *p, int offset, int    value) { *((short  *) (&p[offset])) = value; }
void	c_put_long	(char *p, int offset, int    value) { *((long   *) (&p[offset])) = value; }
void	c_put_quad	(char *p, int offset, double value) { *((double *) (&p[offset])) = value; }
void	c_put_float	(char *p, int offset, float  value) { *((float  *) (&p[offset])) = value; }
void	c_put_double(char *p, int offset, double value) { *((double *) (&p[offset])) = value; }

void	c_move_char		(char *from, char *to, int count) {  memmove(to, from, count * sizeof(char  )); }
void	c_move_byte		(char *from, char *to, int count) {  memmove(to, from, count * sizeof(char  )); }
void	c_move_short	(char *from, char *to, int count) {  memmove(to, from, count * sizeof(short )); }
void	c_move_long		(char *from, char *to, int count) {  memmove(to, from, count * sizeof(long  )); }
void	c_move_quad		(char *from, char *to, int count) {  memmove(to, from, count * sizeof(double)); }
void	c_move_float	(char *from, char *to, int count) {  memmove(to, from, count * sizeof(float )); }
void	c_move_double	(char *from, char *to, int count) {  memmove(to, from, count * sizeof(double)); }

#define CMP_CODE(type)					\
{	int result;							\
	type *	rp1 = (type *) p1;			\
	type *	rp2 = (type *) p2;			\
										\
	result = 0;							\
	while(count-- > 0 && result == 0)	\
		result = *rp1++ - *rp2++;		\
	return result;						\
}
	
	
int		c_cmp_char	(char *p1, char *p2, int count) CMP_CODE(char)
int		c_cmp_byte	(char *p1, char *p2, int count) CMP_CODE(char)
int		c_cmp_short	(char *p1, char *p2, int count) CMP_CODE(short)
int		c_cmp_long	(char *p1, char *p2, int count) CMP_CODE(long)
int		c_cmp_float	(char *p1, char *p2, int count) CMP_CODE(float)
int		c_cmp_double(char *p1, char *p2, int count) CMP_CODE(double)

/* This code assumes LSB first (Intel) architecture !!! */
int		c_cmp_quad	(char *p1, char *p2, int count)
{	int result;
	long *	rp1 = (long *) p1;
	long *	rp2 = (long *) p2;

	result = 0;
	while(count-- > 0 && result == 0)
	{
		result = rp1[1] - rp2[1];
		if(result == 0)
			result = *rp1 - *rp2;
		rp1 += 2; rp2 += 2;
	}
	return result;
}

int c_cmp_pointer(char *p1, char *p2)
{
	if (p1 < p2)
		return(-1);
	else if(p1 = p2)
		return(0);
	else
		return(1);
}


